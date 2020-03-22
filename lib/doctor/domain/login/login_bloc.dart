import 'dart:math';

import 'package:azap_app/doctor/domain/session/session_bloc.dart';
import 'package:azap_app/doctor/domain/session/session_events.dart';
import 'package:azap_app/stores/doctor.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import '../../../services/http.dart';
import 'login_events.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SessionBloc sessionBloc;

  LoginBloc(this.sessionBloc);

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEvent) {
      yield Logiing();
      try {
        var doctor = Doctor();
        doctor.name = event.userName;
        doctor.phone = event.number;
        doctor.locationId = event.locationId;
        await HttpService().createDoctor(doctor);
        sessionBloc.dispatch(OnSessionCreated(event.locationId != -1));
        yield LoggedIn(event.locationId != null);
      } catch (e) {
        if (e is PlatformException) {
          yield LoggiingFailure(error: e.message);
        } else {
          yield LoggiingFailure(error: "Unknown error");
        }
      }
    }
  }
}
