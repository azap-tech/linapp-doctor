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
  int storeId;

  @observable
  int workerId;

  @observable
  String name;

  @observable
  String phone;

  @observable
  DateTime canceledTime;

  @observable
  DateTime cashedTime;

  @observable
  DateTime creationTime;

  @observable
  DateTime doneTime;

  @observable
  DateTime expectedTime;

  @observable
  DateTime startedTime;

  @observable
  bool azap = false;

  @observable
  bool regularClient = false;

  @action
  void updateWorker(int newWorkerId) {
    workerId = newWorkerId;
  }
}