import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SponsorModel {
  int id;
  String name;
  String url;
  
  SponsorModel({
    required this.id,
    required this.name,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'url': url,
    };
  }

  factory SponsorModel.fromMap(Map<String, dynamic> map) {
    return SponsorModel(
      id: map['id'] as int,
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SponsorModel.fromJson(String source) => SponsorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
