import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class InitialLoginState extends LoginState {
  @override
  String toString() => 'Initial Session State';
}

class Logiing extends LoginState {
  Logiing() : super([]);

  @override
  String toString() => 'SessionLogiing';
}

class LoggedIn extends LoginState {
  final bool isProfileCompleted;

  LoggedIn(this.isProfileCompleted) : super([]);

  @override
  String toString() => 'LoggedIn';
}

class LoggedOut extends LoginState {

  LoggedOut() : super([]);

  @override
  String toString() => 'LoggedOut';
}

class LoggiingFailure extends LoginState {
  final String error;

  LoggiingFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'LoggiingFailure { error: $error }';
}
