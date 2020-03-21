import 'package:azap_app/stores/worker.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class WorkerPayload {
  Worker payload;
  String type = "";
}