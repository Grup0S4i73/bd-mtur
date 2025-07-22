import 'dart:io';

import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/models/comment_model.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:bd_mtur/models/learning_object_model_DTO.dart';
import 'package:bd_mtur/models/object_type_model.dart';
import 'package:bd_mtur/models/user_review_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_api.dart';

class LearningObjectRepository {
  final dio = Dio();

  Future<List<LearningObjectModel>> getLearningObjectOfObjectType(
      int objectType_id) async {
    try {
      final url = '${AppApi.api}/educationalObject/type/${objectType_id}';
      final response = await dio.get<List>(url);
      return response.data!
          .map((resp) => LearningObjectModel.fromMap(resp))
          .toList();
    } catch (e) {
      throw e;
    }
  }

  Future<List<LearningObjectModel>> getLearningObjectOfTopic(
      int topic_id) async {
    try {
      final url = '${AppApi.api}/topic/${topic_id}/educationalObject/';
      final response = await dio.get<List>(url);
      return response.data!
          .map((resp) => LearningObjectModel.fromMap(resp))
          .toList();
    } catch (e) {
      throw e;
    }
  }

  Future<List<LearningObjectModel>> getTopFiveEducationalObjects() async {
    try {
      final url = '${AppApi.api}/educationalObject/';
      final response = await dio.get<List>(url);
      return response.data!
          .map((resp) => LearningObjectModel.fromMap(resp))
          .toList();
    } on DioError catch (e) {
      throw e.error!;
    } on IOException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<LearningObjectModel>> getAllVisited() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] =
        "Bearer ${sharedPreferences.getString('token')}";

    try {
      final url = '${AppApi.api}/user/allvisited/';
      final response = await dio.put<List>(url);
      return response.data!
          .map((resp) => LearningObjectModel.fromMap(resp))
          .toList();
    } on DioError catch (e) {
      print("Dio" + e.toString());
      throw e.error!;
    } on IOException catch (e) {
      print("IO" + e.toString());
      rethrow;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<List<LearningObjectModel>> getAllEducationalObject() async {
    try {
      final url = '${AppApi.api}/educationalObject/';
      final response = await dio.get<List>(url);
      return response.data!
          .map((resp) => LearningObjectModel.fromMap(resp))
          .toList();
    } on SocketException catch (e) {
      throw Exception("Erro de conexão");
    } catch (e) {
      return [];
    }
  }

  Future<List<LearningObjectModel>> getAllFavorites() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] =
        "Bearer ${sharedPreferences.getString('token')}";

    try {
      final url = '${AppApi.api}/user/favorites/';
      final response = await dio.put<List>(url);
      return response.data!
          .map((resp) => LearningObjectModel.fromMap(resp))
          .toList();
    } on DioError catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> setFavorite(int learning_object_id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] =
        "Bearer ${sharedPreferences.getString('token')}";

    try {
      final url =
          '${AppApi.api}/educationalObject/${learning_object_id}/favorite';
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            "authorization": "Bearer ${sharedPreferences.getString('token')}"
          },
        ),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> setVisited(int learning_object_id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] =
        "Bearer ${sharedPreferences.getString('token')}";

    try {
      final url = '${AppApi.api}/educationalObject/${learning_object_id}/visit';
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            "authorization": "Bearer ${sharedPreferences.getString('token')}"
          },
        ),
      );
      if (response.statusCode == 201 || response.statusCode == 422) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<LearningObjectModelDTO?> setReview(
      int learning_object_id, double review) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] =
        "Bearer ${sharedPreferences.getString('token')}";

    try {
      final url =
          '${AppApi.api}/educationalObject/${learning_object_id}/review';
      final response = await dio.post(
        url,
        data: {
          "score": review,
        },
        options: Options(
          headers: {
            "authorization": "Bearer ${sharedPreferences.getString('token')}"
          },
        ),
      );
      if (response.data == null) {
        return null;
      } else {
        return LearningObjectModelDTO.fromMap(response.data!);
      }
    } on DioError catch (e) {
      if (e.error!.toString().contains("SocketException")) {
        throw "Erro de conexão";
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> setComment(
      int learning_object_id, DateTime created_at, String description) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] =
        "Bearer ${sharedPreferences.getString('token')}";

    try {
      final url =
          '${AppApi.api}/educationalObject/${learning_object_id}/comment';
      final response = await dio.post(
        url,
        data: {
          "created_at": created_at.toString(),
          "description": description,
        },
        options: Options(
          headers: {
            "authorization": "Bearer ${sharedPreferences.getString('token')}"
          },
        ),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (e) {
      throw Exception("Erro de conexão");
    } on DioError catch (e) {
      if (e.message!.contains("SocketException")) {
        throw Exception("Erro de conexão");
      }
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<List<CommentModel>> getAllComments(int learning_object_id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final url =
          '${AppApi.api}/educationalObject/${learning_object_id}/comments';
      final response = await dio.get<List>(url);

      return response.data!.map((resp) => CommentModel.fromMap(resp)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<ObjectTypeModel>> getAllObjectType() async {
    try {
      final url = '${AppApi.api}/objectType/';
      final response = await dio.get<List>(url);
      return response.data!
          .map((resp) => ObjectTypeModel.fromMap(resp))
          .toList();
    } on SocketException catch (e) {
      throw Exception("Erro de conexão.");
    } catch (e) {
      return [];
    }
  }

  Future<UserReviewModel> getReviewObject(int learning_object_id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] =
        "Bearer ${sharedPreferences.getString('token')}";

    try {
      final url =
          '${AppApi.api}/educationalObject/${learning_object_id}/review';
      final response = await dio.get(url);
      return UserReviewModel.fromMap(response.data);
    } on SocketException catch (e) {
      throw Exception("Erro de conexão");
    } on DioError catch (e) {
      if (e.message!.contains("SocketException")) {
        throw Exception("Erro de conexão");
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
