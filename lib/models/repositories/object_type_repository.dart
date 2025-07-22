import 'package:bd_mtur/core/app_api.dart';
import 'package:bd_mtur/models/object_type_model.dart';
import 'package:dio/dio.dart';

class ObjectTypeRepository {
  final dio = Dio();

  Future<List<ObjectTypeModel>> getAllObjectType() async {
    try {
      final url = '${AppApi.api}/objectType/';
      final response = await dio.get<List>(url);
      return response.data!
          .map((resp) => ObjectTypeModel.fromMap(resp))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
