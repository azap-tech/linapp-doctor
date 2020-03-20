// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workers.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Workers on _Workers, Store {
  final _$listAtom = Atom(name: '_Workers.list');

  @override
  ObservableList<Worker> get list {
    _$listAtom.context.enforceReadPolicy(_$listAtom);
    _$listAtom.reportObserved();
    return super.list;
  }

  @override
  set list(ObservableList<Worker> value) {
    _$listAtom.context.conditionallyRunInAction(() {
      super.list = value;
      _$listAtom.reportChanged();
    }, _$listAtom, name: '${_$listAtom.name}_set');
  }

  final _$_WorkersActionController = ActionController(name: '_Workers');

  @override
  void addWorker(Worker worker) {
    final _$actionInfo = _$_WorkersActionController.startAction();
    try {
      return super.addWorker(worker);
    } finally {
      _$_WorkersActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addWorkers(List<Worker> workers) {
    final _$actionInfo = _$_WorkersActionController.startAction();
    try {
      return super.addWorkers(workers);
    } finally {
      _$_WorkersActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'list: ${list.toString()}';
    return '{$string}';
  }
}
