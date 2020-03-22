import 'package:azap_app/doctor/domain/session/session_bloc.dart';
import 'package:azap_app/doctor/domain/session/session_events.dart';
import 'package:azap_app/doctor/domain/session/session_state.dart';
import 'package:azap_app/doctor/presentation/onboarding/add_location_page.dart';
import 'package:azap_app/doctor/presentation/onboarding/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectedWidget extends StatefulWidget {
  ConnectedWidget({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  _ConnectedWidgetState createState() => _ConnectedWidgetState();
}

class _ConnectedWidgetState extends State<ConnectedWidget> {
  @override
  Widget build(BuildContext context) {
    final _sessionBloc = BlocProvider.of<SessionBloc>(context);

    return BlocBuilder(
        bloc: _sessionBloc,
        builder: (BuildContext context, SessionState state) {
          if (state is LoggedIn) {
            return widget.child;
          } else if (state is LoggedInProfileNotCompleted) {
            return AddLocationPage();
          } else if (state is LoggedOut) {
            return LoginPage();
          } else {
            _sessionBloc.dispatch(GetSessionState());
            return CircularProgressIndicator();
          }
        });
  }
}
