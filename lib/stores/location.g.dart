// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Location on _Location, Store {
  final _$idAtom = Atom(name: '_Location.id');

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

  final _$nameAtom = Atom(name: '_Location.name');

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

  final _$addressAtom = Atom(name: '_Location.address');

  @override
  String get address {
    _$addressAtom.context.enforceReadPolicy(_$addressAtom);
    _$addressAtom.reportObserved();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.context.conditionallyRunInAction(() {
      super.address = value;
      _$addressAtom.reportChanged();
    }, _$addressAtom, name: '${_$addressAtom.name}_set');
  }

  final _$zipCodeAtom = Atom(name: '_Location.zipCode');

  @override
  String get zipCode {
    _$zipCodeAtom.context.enforceReadPolicy(_$zipCodeAtom);
    _$zipCodeAtom.reportObserved();
    return super.zipCode;
  }

  @override
  set zipCode(String value) {
    _$zipCodeAtom.context.conditionallyRunInAction(() {
      super.zipCode = value;
      _$zipCodeAtom.reportChanged();
    }, _$zipCodeAtom, name: '${_$zipCodeAtom.name}_set');
  }

  final _$cityAtom = Atom(name: '_Location.city');

  @override
  String get city {
    _$cityAtom.context.enforceReadPolicy(_$cityAtom);
    _$cityAtom.reportObserved();
    return super.city;
  }

  @override
  set city(String value) {
    _$cityAtom.context.conditionallyRunInAction(() {
      super.city = value;
      _$cityAtom.reportChanged();
    }, _$cityAtom, name: '${_$cityAtom.name}_set');
  }

  final _$location_typeAtom = Atom(name: '_Location.location_type');

  @override
  String get location_type {
    _$location_typeAtom.context.enforceReadPolicy(_$location_typeAtom);
    _$location_typeAtom.reportObserved();
    return super.location_type;
  }

  @override
  set location_type(String value) {
    _$location_typeAtom.context.conditionallyRunInAction(() {
      super.location_type = value;
      _$location_typeAtom.reportChanged();
    }, _$location_typeAtom, name: '${_$location_typeAtom.name}_set');
  }

  @override
  String toString() {
    final string =
        'id: ${id.toString()},name: ${name.toString()},address: ${address.toString()},zipCode: ${zipCode.toString()},city: ${city.toString()},location_type: ${location_type.toString()}';
    return '{$string}';
  }
}
