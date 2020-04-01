import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class LocationPayload {
  int id;
  String name;
  String status = "";
  String pincode = "";
}