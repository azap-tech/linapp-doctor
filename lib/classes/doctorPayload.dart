import 'package:azap_app/stores/doctor.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class DoctorPayload {
  Doctor payload;
  String type = "";
}