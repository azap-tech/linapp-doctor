import 'package:azap_app/doctor/di/locator.dart';
import 'package:azap_app/doctor/domain/session/session_events.dart';
import 'package:azap_app/doctor/domain/session/session_state.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SharedPreferences sharedPreferences;
  bool isInited = false;

  @override
  SessionState get initialState => InitialSessionState();

  @override
  Stream<SessionState> mapEventToState(SessionEvent event) async* {
    if (event is GetSessionState) {
      sharedPreferences = await SharedPreferences.getInstance();
      String toekn = sharedPreferences.getString("token");
      if (toekn == null) {
        sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("token", null);
        isInited = false;
        onDisconnected();
        yield LoggedOut();
      } else {
        sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("token", toekn);
      if (!isInited) {
        setupConnectedLocator(toekn, this);
      }
        isInited = true;
        yield LoggedIn();
      }
    } else if (event is OnSessionExpired) {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("token", null);
      isInited = false;
      onDisconnected();
      yield LoggedOut();
    } else if (event is OnSessionCreated) {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("token", event.token);
      if (!isInited) {
        setupConnectedLocator(event.token, this);
      }
      isInited = true;
      yield LoggedIn();
    } else if (event is LogOutSession) {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("token", null);
      isInited = false;
      onDisconnected();
      yield LoggedOut();
    }
  }
}
