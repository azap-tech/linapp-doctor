import 'package:azap_app/doctor/data/location/location_repository_contract.dart';
import 'package:azap_app/doctor/di/locator.dart';
import 'package:azap_app/doctor/domain/location/location_events.dart';
import 'package:azap_app/doctor/domain/location/location_state.dart';
import 'package:azap_app/doctor/domain/session/session_bloc.dart';
import 'package:azap_app/doctor/domain/session/session_events.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final SessionBloc sessionBloc;
  var locationRepository = locator<LocationRepositoryContract>();

  LocationBloc(this.sessionBloc);

  @override
  LocationState get initialState => InitialLocationState();

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is GetLocationEvent) {
      int locationId = await locationRepository.getLocation();
      if (locationId != null) {
        yield (LocationSet(locationId));
      } else {
        yield (LocationUnset());
      }
    } else if (event is SetLocation) {
      yield SettingLocation();
      try {
        var locationId = await locationRepository.setLocation(event.name);
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
