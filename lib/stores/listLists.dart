import 'package:bd_mtur/stores/listLearningObjectStore.dart';
import 'package:mobx/mobx.dart';
part 'listLists.g.dart';

class ListLists = _ListListsBase with _$ListLists;

abstract class _ListListsBase with Store {
  ObservableList<ListLearningObjectStore> listLearningObject =
      ObservableList<ListLearningObjectStore>();

  @action
  void add(ListLearningObjectStore value) => listLearningObject.add(value);

  @action
  void clear() {
    listLearningObject.forEach((element) {
      element.listLearningObject.clear();
    });

    listLearningObject.clear();
  }
}
