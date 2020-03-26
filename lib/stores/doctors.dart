import 'package:mobx/mobx.dart';
import 'doctor.dart';

// Include generated file
part 'doctors.g.dart';

// This is the class used by rest of your codebase
class Doctors extends _Doctors with _$Doctors {}

// The store-class
abstract class _Doctors with Store {
  @observable
  ObservableList<Doctor> list = ObservableList<Doctor>();

  @action
  void addDoctor(Doctor doctor) {
    list.add(doctor);
  }

  @action
  void addDoctors(List<Doctor> doctors) {
    list.addAll(doctors);
  }
}