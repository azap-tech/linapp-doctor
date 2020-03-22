import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  LocationEvent([List props = const []]) : super();
}

class SetLocation extends LocationEvent {
  final String name;
  final String zipCode;
  final String adresse;
  final String city;

  SetLocation({
    this.name,
    this.zipCode,
    this.adresse,
    this.city
  }) : super([name, zipCode, adresse, city]);

  @override
  String toString() => 'SetLocation';
}

class GetLocationEvent extends LocationEvent {
  @override
  String toString() => 'GetLocationEvent';
}
