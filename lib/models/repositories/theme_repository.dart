import 'dart:convert';
import 'dart:io';

import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:bd_mtur/models/news_model.dart';
import 'package:dio/dio.dart';

import '../../core/app_api.dart';

class ThemeRepository {
  final dio = Dio();

  Future<List<LearningObjectModel>> getTopFiveEducationalObjects() async {
    try {
      final url = '${AppApi.api}/theme/${Core.theme_id}/educationalobject';
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

  Future<List<LearningObjectModel>> getAllEducationalObjectOfType(
      int object_type_id) async {
    try {
      final url = '${AppApi.api}/theme/${Core.theme_id}/type/${object_type_id}';
      final response = await dio.get<List>(url);
      return response.data!
          .map((resp) => LearningObjectModel.fromMap(resp))
          .toList();
    } on SocketException catch (e) {
      throw Exception("Erro de conexão.");
    } catch (e) {
      return [];
    }
  }

  Future<List<LearningObjectModel>> getAllEducationalObject() async {
    try {
      final url = '${AppApi.api}/theme/${Core.theme_id}/educationalObject/';
      final response = await dio.get<List>(url);
      return response.data!
          .map((resp) => LearningObjectModel.fromMap(resp))
          .toList();
    } on SocketException catch (e) {
      throw Exception("Erro de conexão.");
    } catch (e) {
      return [];
    }
  }
}
