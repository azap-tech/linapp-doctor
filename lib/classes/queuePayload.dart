import 'package:azap_app/stores/doctor.dart';
import 'package:azap_app/stores/queue.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class QueuePayload {
  Doctor doctor;
  String status = "";
  List<Queue> queulines;
}