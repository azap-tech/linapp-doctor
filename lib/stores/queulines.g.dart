// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queulines.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Queulines on _Queulines, Store {
  final _$queulinesAtom = Atom(name: '_Queulines.queulines');

  @override
  ObservableList<Queue> get queulines {
    _$queulinesAtom.context.enforceReadPolicy(_$queulinesAtom);
    _$queulinesAtom.reportObserved();
    return super.queulines;
  }

  @override
  set queulines(ObservableList<Queue> value) {
    _$queulinesAtom.context.conditionallyRunInAction(() {
      super.queulines = value;
      _$queulinesAtom.reportChanged();
    }, _$queulinesAtom, name: '${_$queulinesAtom.name}_set');
  }

  @override
  String toString() {
    final string = 'queulines: ${queulines.toString()}';
    return '{$string}';
  }
}
