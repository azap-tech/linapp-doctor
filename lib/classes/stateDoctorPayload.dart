import 'package:azap_app/stores/doctor.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class StateDoctorPayload {
  List<Doctor> doctors;
  String status = "";
}