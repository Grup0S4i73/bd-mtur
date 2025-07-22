import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ObjectTypeModel {
  int id;
  String nameType;
  bool downloadable;

  ObjectTypeModel({
    required this.id,
    required this.nameType,
    required this.downloadable,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name_type': nameType,
      'downloadable': downloadable,
    };
  }

  factory ObjectTypeModel.fromMap(Map<String, dynamic> map) {
    return ObjectTypeModel(
      id: map['id'] as int,
      nameType: map['name_type'] as String,
      downloadable: map['downloadable'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ObjectTypeModel.fromJson(String source) =>
      ObjectTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
