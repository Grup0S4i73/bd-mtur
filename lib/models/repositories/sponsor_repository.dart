import 'dart:convert';
import 'dart:io';

import 'package:bd_mtur/models/sponsor_model.dart';
import 'package:dio/dio.dart';

import '../../core/app_api.dart';

class SponsorRepository {
  final dio = Dio();

  Future<SponsorModel> getSponsor(int id) async {
    try {
      final url = '${AppApi.api}/institution/$id';
      final response = await dio.get(url);
      return SponsorModel.fromMap(response.data!);
    } on DioError catch (e) {
      throw e.error!;
    } on IOException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SponsorModel>> getSponsors() async {
    try {
      final url = '${AppApi.api}/institution/';
      final response = await dio.get<List>(url);
      return response.data!.map((resp) => SponsorModel.fromMap(resp)).toList();
    } on DioError catch (e) {
      throw e.error!;
    } on IOException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
