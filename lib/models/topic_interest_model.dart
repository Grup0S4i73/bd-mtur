// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TopicInterestModel {
  int id;
  String name;
  
  TopicInterestModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory TopicInterestModel.fromMap(Map<String, dynamic> map) {
    return TopicInterestModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TopicInterestModel.fromJson(String source) => TopicInterestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
