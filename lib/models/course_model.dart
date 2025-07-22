// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CourseModel {
  int id;
  String name;
  int workload;
  int numberOfResources;
  DateTime releaseDate;
  bool recentRelease;
  String url;
  String urlImage;

  CourseModel({
    required this.id,
    required this.name,
    required this.workload,
    required this.releaseDate,
    required this.recentRelease,
    required this.numberOfResources,
    required this.url,
    required this.urlImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'workload': workload,
      'release_date': releaseDate,
      'recent_release': recentRelease,
      'number_of_resources': numberOfResources,
      'url': url,
      'url_image': urlImage,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] as int,
      name: map['name'] as String,
      workload: map['workload'] as int,
      releaseDate: DateTime.parse(map['release_date']),
      recentRelease: map['recent_release'] as bool,
      numberOfResources: map['number_of_resources'] as int,
      url: map['url'] as String,
      urlImage: map['url_image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
