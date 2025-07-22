// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:bd_mtur/models/repositories/theme_repository.dart';

class ThemeController {
  final repository = ThemeRepository();

  static final ThemeController _instance = ThemeController._();

  ThemeController._();

  factory ThemeController() {
    return _instance;
  }

  Future<List<LearningObjectModel>> getTopFiveEducationalObjects() async {
    try {
      final list = await repository.getTopFiveEducationalObjects();
      list.sort((a, b) => a.averageGrade > b.averageGrade
          ? -1
          : 1); //Ordenação por nota do recurso

      return list.getRange(0, list.length > 5 ? 5 : list.length).toList();
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
      return await repository.getAllEducationalObjectOfType(object_type_id);
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
}
