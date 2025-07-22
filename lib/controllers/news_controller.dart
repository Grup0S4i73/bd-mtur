import 'dart:io';

import 'package:bd_mtur/core/app_images.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:dio/dio.dart';

import '../models/news_model.dart';
import '../models/repositories/news_repository.dart';

class NewsController {
  final repository = NewsRepository();

  static final NewsController _instance = NewsController._internal();

  factory NewsController() {
    return _instance;
  }

  NewsController._internal();

  Future<List<NewsModel>> getAllRecentNews() async {
    try {
      List<NewsModel> listNews = await repository.getAllRecentNews();
      listNews.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return listNews;
    } on DioError catch (e) {
      throw e.error!;
    } on IOException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
