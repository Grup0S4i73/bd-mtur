import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserReviewModel {
  int userReviewObjectId;
	int userId;
	int educationalObjectId;
	double score;
  
  UserReviewModel({
    required this.userReviewObjectId,
    required this.userId,
    required this.educationalObjectId,
    required this.score,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_review_object_id': userReviewObjectId,
      'user_id': userId,
      'educational_object_id': educationalObjectId,
      'score': score,
    };
  }

  factory UserReviewModel.fromMap(Map<String, dynamic> map) {
    return UserReviewModel(
      userReviewObjectId: map['user_review_object_id'] as int,
      userId: map['user_id'] as int,
      educationalObjectId: map['educational_object_id'] as int,
      score: double.parse(map['score']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserReviewModel.fromJson(String source) => UserReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
