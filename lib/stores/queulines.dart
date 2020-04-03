import 'package:azap_app/stores/queue.dart';
import 'package:mobx/mobx.dart';

part 'queulines.g.dart';

class Queulines extends _Queulines with _$Queulines {}

// The store-class
abstract class _Queulines with Store {
  @observable
  ObservableList<Queue> queulines = ObservableList<Queue>();
}