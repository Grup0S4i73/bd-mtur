import 'dart:io';

import 'package:bd_mtur/core/app_icons.dart';
import 'package:bd_mtur/models/topic_interest_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/repositories/topic_interest_repository.dart';

class TopicInterestController {
  final repository = TopicInterestRepository();

  static final TopicInterestController _instance =
      TopicInterestController._internal();

  factory TopicInterestController() {
    return _instance;
  }

  TopicInterestController._internal();

  Future<List<TopicInterestModel>> getAllTopicInterest() async {
    try {
      return await repository.getAllTopicInterest();
    } on DioError catch (e) {
      throw e.error!;
    } on IOException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
