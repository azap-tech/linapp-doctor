import 'package:equatable/equatable.dart';

abstract class SessionEvent extends Equatable {
  SessionEvent([List props = const []]) : super();
}

class GetSessionState extends SessionEvent {
  @override
  String toString() => 'GetSessionState';
}

class LogOutSession extends SessionEvent {
  @override
  String toString() => 'LogOutSession';
}

class OnSessionExpired extends SessionEvent {
  @override
  String toString() => 'OnSessionExpired';
}

class OnSessionCreated extends SessionEvent {
  final String token;
  OnSessionCreated(this.token);

  @override
  String toString() => 'OnSessionCreated';
}
