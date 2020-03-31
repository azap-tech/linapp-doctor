// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Doctor on _Doctor, Store {
  final _$listPatientsAtom = Atom(name: '_Doctor.listPatients');

  @override
  ObservableList<Ticket> get listPatients {
    _$listPatientsAtom.context.enforceReadPolicy(_$listPatientsAtom);
    _$listPatientsAtom.reportObserved();
    return super.listPatients;
  }

  @override
  set listPatients(ObservableList<Ticket> value) {
    _$listPatientsAtom.context.conditionallyRunInAction(() {
      super.listPatients = value;
      _$listPatientsAtom.reportChanged();
    }, _$listPatientsAtom, name: '${_$listPatientsAtom.name}_set');
  }

  final _$idAtom = Atom(name: '_Doctor.id');

  @override
  int get id {
    _$idAtom.context.enforceReadPolicy(_$idAtom);
    _$idAtom.reportObserved();
    return super.id;
  }

  @override
  set id(int value) {
    _$idAtom.context.conditionallyRunInAction(() {
      super.id = value;
      _$idAtom.reportChanged();
    }, _$idAtom, name: '${_$idAtom.name}_set');
  }

  final _$locationIdAtom = Atom(name: '_Doctor.locationId');

  @override
  int get locationId {
    _$locationIdAtom.context.enforceReadPolicy(_$locationIdAtom);
    _$locationIdAtom.reportObserved();
    return super.locationId;
  }

  @override
  set locationId(int value) {
    _$locationIdAtom.context.conditionallyRunInAction(() {
      super.locationId = value;
      _$locationIdAtom.reportChanged();
    }, _$locationIdAtom, name: '${_$locationIdAtom.name}_set');
  }

  final _$nameAtom = Atom(name: '_Doctor.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$emailAtom = Atom(name: '_Doctor.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$phoneAtom = Atom(name: '_Doctor.phone');

  @override
  String get phone {
    _$phoneAtom.context.enforceReadPolicy(_$phoneAtom);
    _$phoneAtom.reportObserved();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.context.conditionallyRunInAction(() {
      super.phone = value;
      _$phoneAtom.reportChanged();
    }, _$phoneAtom, name: '${_$phoneAtom.name}_set');
  }

  final _$rgpdAtom = Atom(name: '_Doctor.rgpd');

  @override
  bool get rgpd {
    _$rgpdAtom.context.enforceReadPolicy(_$rgpdAtom);
    _$rgpdAtom.reportObserved();
    return super.rgpd;
  }

  @override
  set rgpd(bool value) {
    _$rgpdAtom.context.conditionallyRunInAction(() {
      super.rgpd = value;
      _$rgpdAtom.reportChanged();
    }, _$rgpdAtom, name: '${_$rgpdAtom.name}_set');
  }

  final _$_DoctorActionController = ActionController(name: '_Doctor');

  @override
  void addPatient(Ticket ticket) {
    final _$actionInfo = _$_DoctorActionController.startAction();
    try {
      return super.addPatient(ticket);
    } finally {
      _$_DoctorActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePatient(Ticket ticket) {
    final _$actionInfo = _$_DoctorActionController.startAction();
    try {
      return super.removePatient(ticket);
    } finally {
      _$_DoctorActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDoctor(Doctor doctor) {
    final _$actionInfo = _$_DoctorActionController.startAction();
    try {
      return super.setDoctor(doctor);
    } finally {
      _$_DoctorActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'listPatients: ${listPatients.toString()},id: ${id.toString()},locationId: ${locationId.toString()},name: ${name.toString()},email: ${email.toString()},phone: ${phone.toString()},rgpd: ${rgpd.toString()}';
    return '{$string}';
  }
}
