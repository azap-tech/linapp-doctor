import 'package:azap_app/stores/ticket.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:mobx/mobx.dart';

part 'queue.g.dart';

@jsonSerializable
class Queue extends _Queue with _$Queue {}

@jsonSerializable
abstract class _Queue with Store {
  @observable
  ObservableList<Ticket> tickets = ObservableList<Ticket>();

  @observable
  int doctorId;

  @observable
  int locationId;

  @observable
  String name;

  @action
  void addTicket(Ticket ticket) {
    tickets.add(ticket);
  }

  @action
  void removeTicket(Ticket ticket) {
    tickets.remove(ticket);
  }

  @action
  void reorderTickets() {
    tickets.sort((a,b) => a.creationTime.compareTo(b.creationTime));
  }

  @action
  void updateTicket(Ticket ticket) {
    int index = tickets.indexWhere((patient) { return patient.id == ticket.id;});
    if(index > -1){
      tickets.removeAt(index);
      tickets.insert(index, ticket);
    } else {
      tickets.add(ticket);
    }
  }
}