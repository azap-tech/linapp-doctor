// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Doctor on _Doctor, Store {
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

  @override
  String toString() {
    final string =
        'id: ${id.toString()},locationId: ${locationId.toString()},name: ${name.toString()},phone: ${phone.toString()}';
    return '{$string}';
  }
}
