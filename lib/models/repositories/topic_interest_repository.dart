import 'dart:convert';
import 'dart:io';

import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:bd_mtur/models/news_model.dart';
import 'package:bd_mtur/models/topic_interest_model.dart';
import 'package:dio/dio.dart';

import '../../core/app_api.dart';

class TopicInterestRepository {
  final dio = Dio();

  Future<List<TopicInterestModel>> getAllTopicInterest() async {
    try {
      final url = '${AppApi.api}/topic/';
      final response = await dio.get<List>(url);
      return response.data!
          .map((resp) => TopicInterestModel.fromMap(resp))
          .toList();
    } on DioError catch (e) {
      throw e.error!;
    } on IOException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
