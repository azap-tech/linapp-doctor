// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctors.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Doctors on _Doctors, Store {
  final _$listAtom = Atom(name: '_Doctors.list');

  @override
  ObservableList<Doctor> get list {
    _$listAtom.context.enforceReadPolicy(_$listAtom);
    _$listAtom.reportObserved();
    return super.list;
  }

  @override
  set list(ObservableList<Doctor> value) {
    _$listAtom.context.conditionallyRunInAction(() {
      super.list = value;
      _$listAtom.reportChanged();
    }, _$listAtom, name: '${_$listAtom.name}_set');
  }

  final _$_DoctorsActionController = ActionController(name: '_Doctors');

  @override
  void addDoctor(Doctor doctor) {
    final _$actionInfo = _$_DoctorsActionController.startAction();
    try {
      return super.addDoctor(doctor);
    } finally {
      _$_DoctorsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addDoctors(List<Doctor> doctors) {
    final _$actionInfo = _$_DoctorsActionController.startAction();
    try {
      return super.addDoctors(doctors);
    } finally {
      _$_DoctorsActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'list: ${list.toString()}';
    return '{$string}';
  }
}
