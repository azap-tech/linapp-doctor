import 'package:azap_app/stores/ticket.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:mobx/mobx.dart';

part 'doctor.g.dart';

@jsonSerializable
class Doctor extends _Doctor with _$Doctor {}

@jsonSerializable
abstract class _Doctor with Store {
  @observable
  ObservableList<Ticket> listPatients = ObservableList<Ticket>();

  @observable
  int id;

  @observable
  int locationId;

  @observable
  String name;

  @observable
  String email;

  @observable
  String phone;

  @observable
  bool rgpd;

  @action
  void addPatient(Ticket ticket) {
    listPatients.add(ticket);
  }

  @action
  void updatePatient(Ticket ticket) {
    int index = listPatients.indexWhere((patient) { return patient.id == ticket.id;});
    if(index > -1){
      listPatients.removeAt(index);
      listPatients.insert(index, ticket);
    } else {
      listPatients.add(ticket);
    }
  }

  @action
  void nextPatient(Ticket newTicket, int oldTicket) {
    int indexOld = listPatients.indexWhere((patient) { return patient.id == oldTicket;});
    if(indexOld > -1){
      listPatients.removeAt(indexOld);
    }
    updatePatient(newTicket);
  }

  @action
  void removePatient(Ticket ticket) {
    listPatients.remove(ticket);
  }

  @action
  void reorderPatients() {
    listPatients.sort((a,b) => a.creationTime.compareTo(b.creationTime));
  }

  @action
  void setDoctor(Doctor doctor) {
    id = doctor.id;
    locationId = doctor.locationId;
    name = doctor.name;
    phone = doctor.phone;
    email = doctor.email;
    rgpd = doctor.rgpd;
    listPatients = doctor.listPatients;
  }
}