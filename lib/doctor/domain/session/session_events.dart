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
  final bool isProfileCompleted;
  OnSessionCreated(this.isProfileCompleted);

  @override
  String toString() => 'OnSessionCreated';
}
