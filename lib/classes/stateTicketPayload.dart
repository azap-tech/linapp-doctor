import 'package:azap_app/stores/ticket.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class StateTicketPayload {
  List<Ticket> tickets;
  String status = "";
}