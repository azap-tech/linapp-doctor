import 'package:azap_app/doctor/di/locator.dart';
import 'package:azap_app/doctor/domain/session/session_events.dart';
import 'package:azap_app/doctor/domain/session/session_state.dart';
import 'package:bloc/bloc.dart';
import 'package:requests/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SharedPreferences sharedPreferences;

  @override
  SessionState get initialState => InitialSessionState();

  @override
  Stream<SessionState> mapEventToState(SessionEvent event) async* {
    if (event is GetSessionState) {
      var cookies = await Requests.getStoredCookies("https/api");
      sharedPreferences = await SharedPreferences.getInstance();
      String isProfileCompleted = sharedPreferences.getString("locationId");
      if (cookies.isEmpty) {
        onDisconnected();
        yield LoggedOut();
      } else {
        if (isProfileCompleted != null) {
          yield LoggedIn();
        } else {
          yield LoggedInProfileNotCompleted();
        }
      }
    } else if (event is OnSessionExpired) {
      Requests.clearStoredCookies("https/api");
      sharedPreferences.setString("locationId", null);
      onDisconnected();
      yield LoggedOut();
    } else if (event is OnSessionCreated) {
      if (event.isProfileCompleted) {
        yield LoggedIn();
      } else {}
    } else if (event is LogOutSession) {
      onDisconnected();
      yield LoggedOut();
    }
  }
}
