import 'package:equatable/equatable.dart';

abstract class SessionState extends Equatable {
  SessionState([List props = const []]) : super(props);
}

class InitialSessionState extends SessionState {
  @override
  String toString() => 'Initial Session State';
}

class LoggedIn extends SessionState {

  LoggedIn() : super([]);

  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends SessionState {

  LoggedOut() : super([]);

  @override
  String toString() => 'LoggedOut';
}
