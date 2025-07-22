import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:mobx/mobx.dart';
part 'favoriteStore.g.dart';

class FavoriteStore = _FavoriteStoreBase with _$FavoriteStore;

abstract class _FavoriteStoreBase with Store {
  late final LearningObjectModel learningObject;

  @observable
  bool isFavorite = false;

  _FavoriteStoreBase(this.learningObject, this.isFavorite);

  @action
  void toogleFavorite() {
    isFavorite = !isFavorite;
  }
}
