import 'package:azap_app/stores/ticket.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class TicketPayload {
  Ticket payload;
  String type = "";
  String status = "";
  int oldTicketId;
  int doctorId;
}