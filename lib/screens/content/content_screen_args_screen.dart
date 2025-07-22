import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:bd_mtur/stores/favoriteStore.dart';

class ContentArgumentsScreen {
  final FavoriteStore learningObject;
  final Function? addFavorite;
  final Function? removeFavorite;

  ContentArgumentsScreen(
      this.learningObject, this.addFavorite, this.removeFavorite);
}
