import 'dart:io';

import 'package:bd_mtur/models/course_model.dart';
import 'package:dio/dio.dart';
import '../models/repositories/course_repository.dart';

class CourseController {
  final repository = CourseRepository();

  static final CourseController _instance = CourseController._internal();

  factory CourseController() {
    return _instance;
  }

  CourseController._internal();

  Future<List<CourseModel>?> getAllCourses() async {
    List<CourseModel> listCourses = [];
    try {
      return await repository.getAllCourses();
    } on DioError catch (e) {
      throw e.error!!;
    } on IOException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<CourseModel> getCourse(int id) async {
    try {
      return await repository.getCourse(id);
    } on DioError catch (e) {
      throw e.error!;
    } on IOException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
