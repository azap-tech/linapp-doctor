// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickets.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Tickets on _Tickets, Store {
  final _$listAtom = Atom(name: '_Tickets.list');

  @override
  ObservableList<Ticket> get list {
    _$listAtom.context.enforceReadPolicy(_$listAtom);
    _$listAtom.reportObserved();
    return super.list;
  }

  @override
  set list(ObservableList<Ticket> value) {
    _$listAtom.context.conditionallyRunInAction(() {
      super.list = value;
      _$listAtom.reportChanged();
    }, _$listAtom, name: '${_$listAtom.name}_set');
  }

  final _$_TicketsActionController = ActionController(name: '_Tickets');

  @override
  void addTicket(Ticket ticket) {
    final _$actionInfo = _$_TicketsActionController.startAction();
    try {
      return super.addTicket(ticket);
    } finally {
      _$_TicketsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTicket(Ticket ticket) {
    final _$actionInfo = _$_TicketsActionController.startAction();
    try {
      return super.removeTicket(ticket);
    } finally {
      _$_TicketsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTickets(List<Ticket> tickets) {
    final _$actionInfo = _$_TicketsActionController.startAction();
    try {
      return super.addTickets(tickets);
    } finally {
      _$_TicketsActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'list: ${list.toString()}';
    return '{$string}';
  }
}
