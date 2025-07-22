import 'dart:io';

import 'package:bd_mtur/models/repositories/sponsor_repository.dart';
import 'package:bd_mtur/models/sponsor_model.dart';

import 'package:dio/dio.dart';

class SponsorController {
  final repository = SponsorRepository();

  static final SponsorController _instance = SponsorController._internal();

  factory SponsorController() {
    return _instance;
  }

  SponsorController._internal();

  Future<SponsorModel> getSponsor(int id) async {
    try {
      return await repository.getSponsor(id);
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
      return await repository.getSponsors();
    } on DioError catch (e) {
      throw e.error!;
    } on IOException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
