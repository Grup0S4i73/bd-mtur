import 'package:bd_mtur/core/app_screens.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:bd_mtur/stores/favoriteStore.dart';
import 'package:mobx/mobx.dart';
part 'listLearningObjectStore.g.dart';

class ListLearningObjectStore = _ListLearningObjectStoreBase
    with _$ListLearningObjectStore;

abstract class _ListLearningObjectStoreBase with Store {
  _autoRun() {
    print(listLearningObject.length);
  }

  ObservableList<FavoriteStore> listLearningObject =
      ObservableList<FavoriteStore>();
  String name_topic = "";

  @action
  void add(FavoriteStore value) => listLearningObject.add(value);

  @action
  void remove(FavoriteStore value) => listLearningObject.remove(value);

  @action
  void setList(List<LearningObjectModel> list,
      List<LearningObjectModel> favorites, String topic_name) {
    name_topic = topic_name;
    list.forEach((data) {
      if (favorites.where((element) => element.id == data.id).isNotEmpty) {
        listLearningObject.add(FavoriteStore(data, true));
      } else {
        listLearningObject.add(FavoriteStore(data, false));
      }
    });
  }

  @action
  void setFavorites(List<LearningObjectModel> list) {
    list.forEach((data) => listLearningObject.add(FavoriteStore(data, true)));
  }

  @action
  ObservableList<FavoriteStore> filter(
      List<FavoriteStore> list, String filterBy, String orderBy) {
    List<FavoriteStore> filteredLearningObject = list;

    if (filterBy.compareTo("Vídeo") == 0) {
      filteredLearningObject = list
          .where((learningObject) =>
              learningObject.learningObject.objectTypeId == 6)
          .toList();
    }

    if (filterBy.compareTo("Infográfico") == 0) {
      filteredLearningObject = list
          .where((learningObject) =>
              learningObject.learningObject.objectTypeId == 4)
          .toList();
    }

    if (filterBy.compareTo("PDF") == 0) {
      filteredLearningObject = list
          .where((learningObject) =>
              learningObject.learningObject.objectTypeId == 1)
          .toList();
    }

    if (filterBy.compareTo("Podcast") == 0) {
      filteredLearningObject = list
          .where((learningObject) =>
              learningObject.learningObject.objectTypeId == 5)
          .toList();
    }

    if (filterBy.compareTo("Ebook") == 0) {
      filteredLearningObject = list
          .where((learningObject) =>
              learningObject.learningObject.objectTypeId == 2)
          .toList();
    }

    if (filterBy.compareTo("Game Case") == 0) {
      filteredLearningObject = list
          .where((learningObject) =>
              learningObject.learningObject.objectTypeId == 3)
          .toList();
    }

    if (filterBy.compareTo("Recurso Multimídia") == 0) {
      filteredLearningObject = listLearningObject
          .where((learningObject) =>
              learningObject.learningObject.objectTypeId == 7)
          .toList();
    }

    if (orderBy.compareTo("Nome") == 0) {
      Comparator<FavoriteStore> nameComparator = (a, b) =>
          a.learningObject.shortName.compareTo(b.learningObject.shortName);
      filteredLearningObject.sort(nameComparator);
    }

    if (orderBy.compareTo("Avaliação") == 0) {
      Comparator<FavoriteStore> scoreComparator = (a, b) => b
          .learningObject.averageGrade
          .compareTo(a.learningObject.averageGrade);
      filteredLearningObject.sort(scoreComparator);
    }

    return filteredLearningObject.asObservable();
  }

  @action
  ObservableList<FavoriteStore> search(
      String query, String filterBy, String orderBy) {
    return filter(
        listLearningObject
            .where((learningObject) =>
                learningObject.learningObject.fullName
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                learningObject.learningObject.shortName
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList(),
        filterBy,
        orderBy);
  }

  @action
  void clear() {
    listLearningObject.clear();
  }
}
