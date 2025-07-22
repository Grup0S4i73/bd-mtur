import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommentModel {
  int userId;
  String userName;
  DateTime created_at;
  String description;
  
  CommentModel({
    required this.userId,
    required this.userName,
    required this.created_at,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'user_name': userName,
      'created_at': created_at,
      'description': description,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      userId: map['user_id'] as int,
      userName: map['user_name'] as String,
      created_at: DateTime.parse(map['created_at']),
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
