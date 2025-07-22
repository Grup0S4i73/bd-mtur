import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:bd_mtur/stores/favoriteStore.dart';
import 'package:mobx/mobx.dart';

class ContinueContentArgumentsScreen {
  final String title;
  final ObservableList<FavoriteStore> listLearningObject;

  ContinueContentArgumentsScreen(this.title, this.listLearningObject);
}
