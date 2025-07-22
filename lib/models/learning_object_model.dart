// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bd_mtur/core/app_images.dart';
import 'package:bd_mtur/models/topic_interest_model.dart';

class LearningObjectModel {
  int id;
  String shortName;
  String fullName;
  String abstract;
  DateTime releaseDate;
  String urlObject;
  String urlDownload;
  int numberReviews;
  int numberAccess;
  int numberComments;
  int numberLikes;
  num averageGrade;

  int courseId;
  int objectTypeId;

  String urlImage;

  List<TopicInterestModel> topics = [];

  LearningObjectModel({
    required this.id,
    required this.shortName,
    required this.fullName,
    required this.abstract,
    required this.releaseDate,
    required this.urlObject,
    required this.urlDownload,
    required this.numberReviews,
    required this.numberAccess,
    required this.numberComments,
    required this.numberLikes,
    required this.averageGrade,
    required this.urlImage,
    required this.courseId,
    required this.objectTypeId,
    required this.topics,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'short_name': shortName,
      'full_name': fullName,
      'abstract': abstract,
      'release_date': releaseDate,
      'url_object': urlObject,
      'url_download': urlDownload,
      'number_reviews': numberReviews,
      'number_access': numberAccess,
      'number_comments': numberComments,
      'number_likes': numberLikes,
      'average_grade': averageGrade,
      'course_id': courseId,
      'object_type_id': objectTypeId,
      'url_image': urlImage,
      'topics': topics.map((x) => x.toMap()).toList(),
    };
  }

  factory LearningObjectModel.fromMap(Map<String, dynamic> map) {
    return LearningObjectModel(
      id: map['id'] as int,
      shortName: map['short_name'] as String,
      fullName: map['full_name'] as String,
      abstract: map['abstract'] as String,
      releaseDate: DateTime.parse(map['release_date']),
      urlObject: map['url_object'] as String,
      urlDownload: map['url_download'] as String,
      numberReviews: map['number_reviews'] as int,
      numberAccess: map['number_access'] as int,
      numberComments: map['number_comments'] as int,
      numberLikes: map['number_likes'] as int,
      averageGrade: double.parse(map['average_grade']),
      courseId: map['course_id'] as int,
      objectTypeId: map['object_type_id'] as int,
      urlImage: map['url_image'] as String,
      topics: List<TopicInterestModel>.from(
          map['topics'].map((x) => TopicInterestModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory LearningObjectModel.fromJson(String source) =>
      LearningObjectModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
