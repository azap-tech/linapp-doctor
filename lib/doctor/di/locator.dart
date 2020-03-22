import 'package:azap_app/doctor/domain/session/session_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();
void setupLocator() {
}

void setupConnectedLocator(String token, SessionBloc session) {
}

void onDisconnected() {
  locator.reset();
  setupLocator();
}
