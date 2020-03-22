import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:mobx/mobx.dart';

part 'doctor.g.dart';

@jsonSerializable
class Doctor extends _Doctor with _$Doctor {}

@jsonSerializable
abstract class _Doctor with Store {

  @observable
  int id;

  @observable
  int locationId;

  @observable
  String name;

  @observable
  String phone;
}