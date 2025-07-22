// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NewsModel {
  int numero;
  String id;
  String titulo;
  String? subtitulo;
  String corpoDoTexto;
  String refImgs;
  String autor;
  String modificadoPor;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  NewsModel({
    required this.numero,
    required this.id,
    required this.titulo,
    required this.subtitulo,
    required this.corpoDoTexto,
    required this.refImgs,
    required this.autor,
    required this.modificadoPor,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numero': numero,
      'id': id,
      'titulo': titulo,
      'subtitulo': subtitulo,
      'corpoDoTexto': corpoDoTexto,
      'refImgs': refImgs,
      'autor': autor,
      'modificadoPor': modificadoPor,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'v': v,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      numero: map['numero'] as int,
      id: map['_id'] as String,
      titulo: map['titulo'] as String,
      subtitulo: map['subtitulo'] != null ? map['subtitulo'] as String : "",
      corpoDoTexto: map['corpoDoTexto'] as String,
      refImgs: map['refImgs'] as String,
      autor: map['autor'] as String,
      modificadoPor: map['modificadoPor'] as String,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      v: map['__v'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
