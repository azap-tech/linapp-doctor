import 'package:equatable/equatable.dart';

abstract class SessionEvent extends Equatable {
  SessionEvent([List props = const []]) : super();
}

class LoginEvent extends SessionEvent {
  final String userName;
  final String number;
  final int locationId;

  LoginEvent({
    this.userName,
    this.number,
    this.locationId
  }) : super([userName, number, locationId]);

  @override
  String toString() => 'LoginEvent';
}

class GetTokenEvent extends SessionEvent {
  @override
  String toString() => 'GetToken';
}
