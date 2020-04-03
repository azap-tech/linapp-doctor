import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:mobx/mobx.dart';

part 'ticket.g.dart';

@jsonSerializable
class Ticket extends _Ticket with _$Ticket {}

@jsonSerializable
abstract class _Ticket with Store {

  @observable
  int id;

  @observable
  int locationId;

  @observable
  int doctorId;

  @observable
  int age;

  @observable
  String name;

  @observable
  String sex;

  @observable
  String phone;

  @observable
  DateTime canceledTime;

  @observable
  DateTime creationTime;

  @observable
  DateTime doneTime;

  @observable
  DateTime expectedTime;

  @observable
  DateTime startedTime;

  @action
  void updateDoctor(int newDoctorId) {
    doctorId = newDoctorId;
  }
}