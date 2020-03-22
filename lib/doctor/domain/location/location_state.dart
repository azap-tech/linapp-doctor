import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LocationState extends Equatable {
  LocationState([List props = const []]) : super(props);
}

class InitialLocationState extends LocationState {
  @override
  String toString() => 'Initial LocationState State';
}

class SettingLocation extends LocationState {
  SettingLocation() : super([]);

  @override
  String toString() => 'SettingLocation';
}

class LocationSet extends LocationState {
  final String locationId;

  LocationSet(this.locationId) : super([]);

  @override
  String toString() => 'LocationSet';
}

class LocationUnset extends LocationState {

  LocationUnset() : super([]);

  @override
  String toString() => 'LocationUnset';
}

class SettingLocationFailed extends LocationState {
  final String error;

  SettingLocationFailed({@required this.error}) : super([error]);

  @override
  String toString() => 'LoggiingFailure { error: $error }';
}
