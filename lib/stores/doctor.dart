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
  String phone;
}