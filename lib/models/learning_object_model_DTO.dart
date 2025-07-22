// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
// import 'dart:ffi';

import 'package:bd_mtur/core/app_images.dart';
import 'package:bd_mtur/models/topic_interest_model.dart';

class LearningObjectModelDTO {
  int numberReviews;
  num averageGrade;

  LearningObjectModelDTO({
    required this.numberReviews,
    required this.averageGrade,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number_reviews': numberReviews,
      'average_grade': averageGrade,
    };
  }

  factory LearningObjectModelDTO.fromMap(Map<String, dynamic> map) {
    return LearningObjectModelDTO(
      numberReviews: map['number_reviews'] as int,
      averageGrade: map['average_grade'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory LearningObjectModelDTO.fromJson(String source) =>
      LearningObjectModelDTO.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
