import 'dart:io';

import 'package:bd_mtur/core/app_images.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:bd_mtur/models/comment_model.dart';
import 'package:bd_mtur/models/learning_object_model_DTO.dart';
import 'package:bd_mtur/models/object_type_model.dart';
import 'package:bd_mtur/models/user_review_model.dart';
import 'package:dio/dio.dart';

import '../models/learning_object_model.dart';
import '../models/repositories/learning_object_repository.dart';

class LearningObjectController {
  final repository = LearningObjectRepository();

  static final LearningObjectController _instance =
      LearningObjectController._internal();

  factory LearningObjectController() {
    return _instance;
  }

  LearningObjectController._internal();

  Future<List<LearningObjectModel>> getAllVisited() async {
    try {
      return await repository.getAllVisited();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<LearningObjectModel>> getTopFiveEducationalObjects() async {
    try {
      var list = await repository.getTopFiveEducationalObjects();
      list = list.where((resource) => resource.averageGrade != 0).toList();

      list.sort((a, b) => a.averageGrade > b.averageGrade
          ? -1
          : 1); //Ordenação por nota do recurso

      return list.take(5).toList();

    } on DioError catch (e) {
      throw e.error!;
    } on IOException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<LearningObjectModel>> getAllEducationalObjectOfType(
      int object_type_id) async {
    try {
      return await repository.getLearningObjectOfObjectType(object_type_id);
    } on SocketException catch (e) {
      print(e);
      throw Exception("Erro de conexão.");
    } catch (e) {
      return [];
    }
  }

  Future<List<LearningObjectModel>> getAllEducationalObject() async {
    try {
      return await repository.getAllEducationalObject();
    } on SocketException catch (e) {
      throw Exception("Erro de conexão.");
    } catch (e) {
      return [];
    }
  }

  Future<List<LearningObjectModel>> getAllFavorites() async {
    try {
      return await repository.getAllFavorites();
    } on DioError catch (e) {
      print("Dio" + e.toString());
      throw e.error!;
    } on IOException catch (e) {
      print("IO" + e.toString());
      rethrow;
    } catch (e) {
      print("Algo" + e.toString());
      rethrow;
    }
  }

  Future<bool> setFavorite(int learning_object_id) async {
    try {
      return await repository.setFavorite(learning_object_id);
    } catch (e) {
      return false;
    }
  }

  Future<LearningObjectModelDTO?> setReview(
      int learning_object_id, double review) async {
    try {
      return await repository.setReview(learning_object_id, review);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CommentModel>> getAllComments(int learning_object_id) async {
    try {
      return await repository.getAllComments(learning_object_id).then((value) {
        value.sort((a, b) => b.created_at.compareTo(a.created_at));
        return value;
      });
    } catch (e) {
      return [];
    }
  }

  Future<bool> setComment(int learning_object_id, String description) async {
    try {
      return await repository.setComment(
          learning_object_id, DateTime.now(), description);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> setVisited(int learning_object_id) async {
    try {
      return await repository.setVisited(learning_object_id);
    } catch (e) {
      return false;
    }
  }

  Future<List<LearningObjectModel>> getLearningObjectOfObjectType(
      int objectType_id) async {
    try {
      return await repository.getLearningObjectOfObjectType(objectType_id);
    } catch (e) {
      throw e;
    }
  }

  Future<List<LearningObjectModel>> getLearningObjectOfTopic(
      int topic_id) async {
    try {
      return await repository.getLearningObjectOfTopic(topic_id);
    } catch (e) {
      throw e;
    }
  }

  List<LearningObjectModel> searchLearningObjects(
      List<LearningObjectModel> listLearningObject,
      String query,
      String filterBy,
      String orderBy) {
    listLearningObject = listLearningObject
        .where((course) =>
            course.shortName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return filterLearningObjects(listLearningObject, filterBy, orderBy);
  }

  List<LearningObjectModel> filterLearningObjects(
      List<LearningObjectModel> listLearningObject,
      String filterBy,
      String orderBy) {
    List<LearningObjectModel> filteredLearningObject = listLearningObject;

    if (filterBy.compareTo("Todos") == 0) {
      filteredLearningObject = listLearningObject;
    }

    if (filterBy.compareTo("Vídeo") == 0) {
      filteredLearningObject = listLearningObject
          .where((learningObject) => learningObject.objectTypeId == 6)
          .toList();
    }

    if (filterBy.compareTo("Infográfico") == 0) {
      filteredLearningObject = listLearningObject
          .where((learningObject) => learningObject.objectTypeId == 4)
          .toList();
    }

    if (filterBy.compareTo("PDF") == 0) {
      filteredLearningObject = listLearningObject
          .where((learningObject) => learningObject.objectTypeId == 1)
          .toList();
    }

    if (filterBy.compareTo("Podcast") == 0) {
      filteredLearningObject = listLearningObject
          .where((learningObject) => learningObject.objectTypeId == 5)
          .toList();
    }

    if (filterBy.compareTo("Ebook") == 0) {
      filteredLearningObject = listLearningObject
          .where((learningObject) => learningObject.objectTypeId == 2)
          .toList();
    }

    if (filterBy.compareTo("Game Case") == 0) {
      filteredLearningObject = listLearningObject
          .where((learningObject) => learningObject.objectTypeId == 3)
          .toList();
    }

    if (filterBy.compareTo("Recurso Multimídia") == 0) {
      filteredLearningObject = listLearningObject
          .where((learningObject) => learningObject.objectTypeId == 7)
          .toList();
    }

    if (orderBy.compareTo("Nome") == 0) {
      Comparator<LearningObjectModel> nameComparator =
          (a, b) => a.shortName.compareTo(b.shortName);
      filteredLearningObject.sort(nameComparator);
    }

    if (orderBy.compareTo("Avaliação") == 0) {
      Comparator<LearningObjectModel> scoreComparator =
          (a, b) => b.averageGrade.compareTo(a.averageGrade);
      filteredLearningObject.sort(scoreComparator);
    }

    return filteredLearningObject;
  }

  Future<List<ObjectTypeModel>> getAllObjectType() async {
    try {
      return await repository.getAllObjectType();
    } catch (e) {
      throw e;
    }
  }

  Future<UserReviewModel> getReviewObject(int learning_object_id) async {
    try {
      return await repository.getReviewObject(learning_object_id);
    } catch (e) {
      rethrow;
    }
  }
}
