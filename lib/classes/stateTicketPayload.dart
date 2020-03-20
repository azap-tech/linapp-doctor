import 'package:azap_native_manager_app/stores/ticket.dart';
import 'package:azap_native_manager_app/stores/worker.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class StateWorkerPayload {
  List<Worker> workers;
  String status = "";
}