import 'dart:io';

import 'package:bd_mtur/controllers/learning_object_controller.dart';
import 'package:bd_mtur/controllers/theme_controller.dart';
import 'package:bd_mtur/models/topic_interest_model.dart';
import 'package:bd_mtur/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/repositories/user_repository.dart';

class UserController {
  final bool isChecked = false;
  late int amount_resources;
  late int amount_resources_visited;
  late double statusConquest;
  late int level;

  final repository = UserRepository();

  static final UserController _instance = UserController._internal();

  factory UserController() {
    _instance.amount_resources = 0;
    _instance.amount_resources_visited = 0;
    _instance.statusConquest = 0;
    _instance.level = 0;

    return _instance;
  }

  UserController._internal() {
    // init();
  }

  Future<bool> login(
    String email,
    String password,
    bool keepLogin,
  ) async {
    try {
      return await repository.login(email, password, keepLogin);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await repository.logout();
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirm,
    required bool accepted_terms,
    required VoidCallback onSucess,
    required VoidCallback onFail,
    required VoidCallback onPasswordConfirmFail,
    required VoidCallback onAcceptedTermsFail,
  }) async {
    if (password.compareTo(passwordConfirm) == 0) {
      if (accepted_terms == true) {
        try {
          if (await repository.register(
            name: name,
            email: email,
            password: password,
            accepted_terms: accepted_terms,
          )) {
            onSucess();
          } else {
            onFail();
          }
        } catch (e) {
          rethrow;
        }
      } else {
        onAcceptedTermsFail();
      }
    } else {
      return onPasswordConfirmFail();
    }
  }

  Future<UserModel?> getUserData(int id) async {
    return await repository.getUserData(id);
  }

  Future<bool> sendEmail(
    String email,
  ) async {
    try {
      return await repository.sendEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> resendEmail(
    String email,
  ) async {
    try {
      return await repository.sendEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> codeValidation(
    String email,
    String token,
  ) async {
    try {
      return await repository.codeValidation(email, token);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> resetPassword({
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    if (password.compareTo(passwordConfirm) == 0) {
      try {
        return await repository.resetPassword(email, password);
      } catch (e) {
        rethrow;
      }
    } else {
      throw "Senhas diferentes";
    }
  }

  Future<bool> resetPasswordOnly({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirm,
  }) async {
    if (newPassword.compareTo(newPasswordConfirm) == 0) {
      try {
        return await repository.resetPasswordOnly(oldPassword, newPassword);
      } catch (e) {
        rethrow;
      }
    } else {
      throw "Senhas diferentes";
    }
  }

  Future<bool> updateProfile({
    required String name,
  }) async {
    try {
      return await repository.updateProfile(
        name: name,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateProfileImage({
    required File image,
  }) async {
    try {
      String filename = image.path.split('/').last;
      return await repository.updateProfileImage(
        image: image,
        filename: filename,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteUser() async {
    try {
      return await repository.deleteUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyToken() async {
    try {
      return await repository.verifyToken();
    } catch (e) {
      return false;
    }
  }
}
