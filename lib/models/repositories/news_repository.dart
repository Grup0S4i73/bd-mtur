import 'dart:convert';
import 'dart:io';

import 'package:bd_mtur/models/news_model.dart';
import 'package:dio/dio.dart';

import '../../core/app_api.dart';

class NewsRepository {
  final dio = Dio();

  Future<List<NewsModel>> getAllRecentNews() async {
    try {
      final url = '${AppApi.apiNoticias}';
      final response = await dio.get(url);

      return (response.data['query'] as List)
          .map((resp) => NewsModel.fromMap(resp))
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
