// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Worker on _Worker, Store {
  final _$listPatientsAtom = Atom(name: '_Worker.listPatients');

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

  final _$nameAtom = Atom(name: '_Worker.name');

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

  final _$avatarAtom = Atom(name: '_Worker.avatar');

  @override
  String get avatar {
    _$avatarAtom.context.enforceReadPolicy(_$avatarAtom);
    _$avatarAtom.reportObserved();
    return super.avatar;
  }

  @override
  set avatar(String value) {
    _$avatarAtom.context.conditionallyRunInAction(() {
      super.avatar = value;
      _$avatarAtom.reportChanged();
    }, _$avatarAtom, name: '${_$avatarAtom.name}_set');
  }

  final _$storeIdAtom = Atom(name: '_Worker.storeId');

  @override
  int get storeId {
    _$storeIdAtom.context.enforceReadPolicy(_$storeIdAtom);
    _$storeIdAtom.reportObserved();
    return super.storeId;
  }

  @override
  set storeId(int value) {
    _$storeIdAtom.context.conditionallyRunInAction(() {
      super.storeId = value;
      _$storeIdAtom.reportChanged();
    }, _$storeIdAtom, name: '${_$storeIdAtom.name}_set');
  }

  final _$idAtom = Atom(name: '_Worker.id');

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

  final _$phoneAtom = Atom(name: '_Worker.phone');

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

  final _$isManagerAtom = Atom(name: '_Worker.isManager');

  @override
  bool get isManager {
    _$isManagerAtom.context.enforceReadPolicy(_$isManagerAtom);
    _$isManagerAtom.reportObserved();
    return super.isManager;
  }

  @override
  set isManager(bool value) {
    _$isManagerAtom.context.conditionallyRunInAction(() {
      super.isManager = value;
      _$isManagerAtom.reportChanged();
    }, _$isManagerAtom, name: '${_$isManagerAtom.name}_set');
  }

  final _$statusAtom = Atom(name: '_Worker.status');

  @override
  String get status {
    _$statusAtom.context.enforceReadPolicy(_$statusAtom);
    _$statusAtom.reportObserved();
    return super.status;
  }

  @override
  set status(String value) {
    _$statusAtom.context.conditionallyRunInAction(() {
      super.status = value;
      _$statusAtom.reportChanged();
    }, _$statusAtom, name: '${_$statusAtom.name}_set');
  }

  final _$_WorkerActionController = ActionController(name: '_Worker');

  @override
  void updateStatus(String newStatus) {
    final _$actionInfo = _$_WorkerActionController.startAction();
    try {
      return super.updateStatus(newStatus);
    } finally {
      _$_WorkerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'listPatients: ${listPatients.toString()},name: ${name.toString()},avatar: ${avatar.toString()},storeId: ${storeId.toString()},id: ${id.toString()},phone: ${phone.toString()},isManager: ${isManager.toString()},status: ${status.toString()}';
    return '{$string}';
  }
}
