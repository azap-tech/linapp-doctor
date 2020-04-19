import 'package:azap_app/stores/location.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class LocationPayload {
  Location payload;
  String status = "";
  String pincode = "";
}