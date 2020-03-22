import 'package:azap_app/doctor/domain/location/location_events.dart';
import 'package:azap_app/doctor/domain/location/location_state.dart';
import 'package:azap_app/doctor/domain/session/session_bloc.dart';
import 'package:azap_app/doctor/domain/session/session_events.dart';
import 'package:azap_app/services/http.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  SharedPreferences sharedPreferences;
  final SessionBloc sessionBloc;

  LocationBloc(this.sessionBloc);

  @override
  LocationState get initialState => InitialLocationState();

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is GetLocationEvent) {
      sharedPreferences = await SharedPreferences.getInstance();
      String locationId = sharedPreferences.getString("locationId");
      if (locationId != null) {
        yield (LocationSet(locationId));
      } else {
        yield (LocationUnset());
      }
    } else if (event is SetLocation) {
      yield SettingLocation();
      try {
        sharedPreferences = await SharedPreferences.getInstance();
        var locationId = await HttpService()
            .createLocation(event.name);
        sharedPreferences.setString("locationId", locationId);
        sessionBloc.dispatch(OnSessionCreated(true));
        yield LocationSet(locationId);
      } catch (e) {
        if (e is PlatformException) {
          yield SettingLocationFailed(error: e.message);
        } else {
          yield SettingLocationFailed(error: "Unknown error");
        }
      }
    }
  }
}
