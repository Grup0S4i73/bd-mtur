import 'dart:convert';
import 'dart:io';

import 'package:bd_mtur/models/course_model.dart';
import 'package:dio/dio.dart';

import '../../core/app_api.dart';

class CourseRepository {
  final dio = Dio();

  Future<List<CourseModel>> getAllCourses() async {
    try {
      final url = '${AppApi.api}/course';
      final response = await dio.get<List>(url);
      return response.data!.map((resp) => CourseModel.fromMap(resp)).toList();
    } on DioError catch (e) {
      throw e.error!;
    } on IOException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<CourseModel> getCourse(int id) async {
    try {
      final url = '${AppApi.api}/course/$id';
      final response = await dio.get(url);
      return CourseModel.fromMap(response.data!);
    } on DioError catch (e) {
      throw e.error!;
    } on IOException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
