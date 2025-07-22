import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bd_mtur/core/app_api.dart';
import 'package:bd_mtur/models/object_type_model.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../user_model.dart';

class UserRepository {
  final dio = Dio();

  Future<bool> login(String email, String password, bool keepLogin) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    try {
      final response = await dio
          .post(
            '${AppApi.api}/auth',
            data: {"email": email, "password": password},
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 201) {
        final user = response.data['user'];

        sharedPreferences.setString('token', response.data["token"]);
        sharedPreferences.setString('name', user['name']);
        sharedPreferences.setString('email', user["email"]);
        sharedPreferences.setString('profileImage', user["profile_image"]);
        sharedPreferences.setBool('keepLogin', keepLogin);

        return true;
      }

      return false; // status diferente de 201
    } on TimeoutException {
      return false;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 403) {
        throw Exception("Senha incorreta");
      } else if (statusCode == 404) {
        throw Exception("Usuário não existe");
      } else if (e.error.toString().contains("SocketException")) {
        throw const SocketException("Erro de conexão");
      }

      return false;
    }
  }

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required bool accepted_terms,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final response = await dio
          .post(
            '${AppApi.api}/user',
            data: {
              "name": name,
              "email": email,
              "password": password,
              "profile_image": "",
              "accepted_terms": accepted_terms,
            },
          )
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (e) {
      return false;
    } on DioError catch (e) {
      print(e);
      if (e.message == "Http status error [409]") {
        throw "Usuário já existe";
      } else if (e.error!.toString().contains("SocketException")) {
        throw SocketException;
      }
      return false;
    }
  }

  Future<UserModel?> getUserData(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] =
        "Bearer ${sharedPreferences.getString('token')}";

    try {
      final url = '${AppApi.api}/user/${id}';
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            "authorization": "Bearer ${sharedPreferences.getString('token')}",
          },
        ),
      );
      return UserModel.fromMap(response.data!);
    } catch (e) {
      return null;
    }
  }

  Future<bool> sendEmail(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      final response = await dio
          .post('${AppApi.api}/forgotPassword', data: {"email": email})
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        sharedPreferences.setString('email', response.data['email']);
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (e) {
      return false;
    } on DioError catch (e) {
      if (e.message == "Http status error [404]") {
        throw "Usuário não existe";
      } else if (e.error!.toString().contains("SocketException")) {
        throw SocketException;
      }
      return false;
    }
  }

  Future<bool> resendEmail(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      final response = await dio
          .post(
            '${AppApi.api}/forgotPassword',
            data: {"email": sharedPreferences.getString('email')},
          )
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (e) {
      return false;
    } on DioError catch (e) {
      if (e.error!.toString().contains("SocketException")) {
        throw SocketException;
      }
      return false;
    }
  }

  Future<bool> codeValidation(String email, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final response = await dio
          .post(
            '${AppApi.api}/codeValidation',
            data: {
              "email": sharedPreferences.getString('email'),
              "token": token,
            },
          )
          .timeout(Duration(seconds: 5));

      final user = response.data['user'];

      if (response.statusCode == 200) {
        sharedPreferences.setString('email', user['email']);
        sharedPreferences.setString('token', user['token']);
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (e) {
      return false;
    } on DioError catch (e) {
      if (e.message == "Http status error [403]") {
        throw "Código inválido.";
      } else if (e.error!.toString().contains("SocketException")) {
        throw SocketException;
      }
      return false;
    }
  }

  Future<bool> resetPassword(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      final response = await dio
          .post(
            '${AppApi.api}/resetPassword',
            data: {
              "email": sharedPreferences.getString('email'),
              "password": password,
            },
          )
          .timeout(Duration(seconds: 1));

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (e) {
      return false;
    } on DioError catch (e) {
      if (e.error!.toString().contains("SocketException")) {
        throw "Erro de conexão";
      }
      return false;
    }
  }

  Future<bool> resetPasswordOnly(String oldPassword, String newPassword) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['authorization'] =
          "Bearer ${sharedPreferences.getString('token')}";

      final response = await dio
          .post(
            '${AppApi.api}/resetPassword/only-password/',
            data: {"oldPassword": oldPassword, "newPassword": newPassword},
            options: Options(
              headers: {
                "authorization":
                    "Bearer ${sharedPreferences.getString('token')}",
              },
            ),
          )
          .timeout(Duration(seconds: 1));

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (e) {
      return false;
    } on DioError catch (e) {
      if (e.error!.toString().contains("SocketException")) {
        throw "Erro de conexão";
      }
      return false;
    }
  }

  Future<bool> updateProfile({required String name}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['authorization'] =
        "Bearer ${sharedPreferences.getString('token')}";

    try {
      final response = await dio
          .put(
            '${AppApi.api}/user',
            data: {"name": name},
            options: Options(
              headers: {
                "authorization":
                    "Bearer ${sharedPreferences.getString('token')}",
              },
            ),
          )
          .timeout(Duration(seconds: 5));

      if (response.statusCode == 201) {
        sharedPreferences.setString('name', name);
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (e) {
      return false;
    } on DioError catch (e) {
      if (e.error!.toString().contains("SocketException")) {
        throw "Erro de conexão";
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateProfileImage({
    required File image,
    required String filename,
  }) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      FormData formData = new FormData.fromMap({
        "imagem": await MultipartFile.fromFile(
          image.path,
          filename: filename,
          contentType: MediaType('image', 'png'),
        ),
        "type": "image/png",
      });

      final response = await dio.post(
        '${AppApi.api}/user/profileImage',
        data: formData,
        options: Options(
          headers: {
            "authorization": "Bearer ${sharedPreferences.getString('token')}",
            "content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.statusCode == 201) {
        sharedPreferences.setString(
          'profileImage',
          response.data['profile_image'],
        );
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.error!.toString().contains("SocketException")) {
        throw "Erro de conexão";
      }
      if (e.response!.data['error'] == "File too large") {
        throw "File too large";
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUser() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final response = await dio.delete(
        '${AppApi.api}/user/delete',
        options: Options(
          headers: {
            "authorization": "Bearer ${sharedPreferences.getString('token')}",
          },
        ),
      );

      if (response.statusCode == 201) {
        await sharedPreferences.clear();
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.error!.toString().contains("SocketException")) {
        throw "Erro de conexão";
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifyToken() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final response = await dio
          .get(
            '${AppApi.api}/user/verifyToken',
            options: Options(
              headers: {
                "authorization":
                    "Bearer ${sharedPreferences.getString('token')}",
              },
            ),
          )
          .timeout(Duration(seconds: 4));

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
