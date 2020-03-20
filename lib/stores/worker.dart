import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:mobx/mobx.dart';

part 'worker.g.dart';

@jsonSerializable
class Worker extends _Worker with _$Worker {}

enum WorkerStatus { STOPED, AVAILABLE, PAUSE }

@jsonSerializable
abstract class _Worker with Store {
  @observable
  String name = "";

  @observable
  String avatar = "";

  @observable
  int storeId;

  @observable
  int id;

  @observable
  String phone = "";

  @observable
  bool isManager = false;

  @observable
  String status = WorkerStatus.STOPED.toString();

  @action
  void updateStatus(String newStatus) {
    status = newStatus;
  }
}