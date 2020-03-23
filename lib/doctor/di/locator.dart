import 'package:azap_app/doctor/data/location/location_repository.dart';
import 'package:azap_app/doctor/data/location/location_repository_contract.dart';
import 'package:azap_app/doctor/domain/session/session_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();
void setupLocator() {
  locator.registerLazySingleton<LocationRepositoryContract>(
          () => LocationRepository());
}

void setupConnectedLocator(String token, SessionBloc session) {
}

void onDisconnected() {
  locator.reset();
  setupLocator();
}
