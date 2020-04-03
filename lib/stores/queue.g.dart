// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Queue on _Queue, Store {
  final _$ticketsAtom = Atom(name: '_Queue.tickets');

  @override
  ObservableList<Ticket> get tickets {
    _$ticketsAtom.context.enforceReadPolicy(_$ticketsAtom);
    _$ticketsAtom.reportObserved();
    return super.tickets;
  }

  @override
  set tickets(ObservableList<Ticket> value) {
    _$ticketsAtom.context.conditionallyRunInAction(() {
      super.tickets = value;
      _$ticketsAtom.reportChanged();
    }, _$ticketsAtom, name: '${_$ticketsAtom.name}_set');
  }

  final _$doctorIdAtom = Atom(name: '_Queue.doctorId');

  @override
  int get doctorId {
    _$doctorIdAtom.context.enforceReadPolicy(_$doctorIdAtom);
    _$doctorIdAtom.reportObserved();
    return super.doctorId;
  }

  @override
  set doctorId(int value) {
    _$doctorIdAtom.context.conditionallyRunInAction(() {
      super.doctorId = value;
      _$doctorIdAtom.reportChanged();
    }, _$doctorIdAtom, name: '${_$doctorIdAtom.name}_set');
  }

  final _$locationIdAtom = Atom(name: '_Queue.locationId');

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

  final _$nameAtom = Atom(name: '_Queue.name');

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

  final _$_QueueActionController = ActionController(name: '_Queue');

  @override
  void addTicket(Ticket ticket) {
    final _$actionInfo = _$_QueueActionController.startAction();
    try {
      return super.addTicket(ticket);
    } finally {
      _$_QueueActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTicket(Ticket ticket) {
    final _$actionInfo = _$_QueueActionController.startAction();
    try {
      return super.removeTicket(ticket);
    } finally {
      _$_QueueActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reorderTickets() {
    final _$actionInfo = _$_QueueActionController.startAction();
    try {
      return super.reorderTickets();
    } finally {
      _$_QueueActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTicket(Ticket ticket) {
    final _$actionInfo = _$_QueueActionController.startAction();
    try {
      return super.updateTicket(ticket);
    } finally {
      _$_QueueActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'tickets: ${tickets.toString()},doctorId: ${doctorId.toString()},locationId: ${locationId.toString()},name: ${name.toString()}';
    return '{$string}';
  }
}
