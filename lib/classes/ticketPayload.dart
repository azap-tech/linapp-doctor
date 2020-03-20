import 'package:azap_native_manager_app/stores/ticket.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class TicketPayload {
  Ticket payload;
  String type = "";
}