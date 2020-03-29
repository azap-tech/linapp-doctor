import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:mobx/mobx.dart';

part 'location.g.dart';

@jsonSerializable
class Location extends _Location with _$Location {}

@jsonSerializable
abstract class _Location with Store {

  @observable
  int id;

  @observable
  String name;

  @observable
  String address;

  @observable
  String zipCode;

  @observable
  String city;
}