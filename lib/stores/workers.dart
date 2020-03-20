import 'package:mobx/mobx.dart';
import 'worker.dart';

// Include generated file
part 'workers.g.dart';

// This is the class used by rest of your codebase
class Workers extends _Workers with _$Workers {}

// The store-class
abstract class _Workers with Store {
  @observable
  ObservableList<Worker> list = ObservableList<Worker>();

  @action
  void addWorker(Worker worker) {
    list.add(worker);
  }

  @action
  void addWorkers(List<Worker> workers) {
    list.addAll(workers);
  }
}