import 'dart:io';

import 'package:bd_mtur/controllers/learning_object_controller.dart';
import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/app_api.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:bd_mtur/models/topic_interest_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<FormState> _keyName = GlobalKey<FormState>();
  final GlobalKey<FormState> _keyProfileImage = GlobalKey<FormState>();
  final GlobalKey<FormState> _keyPassword = GlobalKey<FormState>();

  final UserController userController = new UserController();
  final LearningObjectController _controllerLearningObject =
      new LearningObjectController();

  String _profileImage = "";
  File image = File("");
  final _nameController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordConfirmController = TextEditingController();

  getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      _nameController.text = sharedPreferences.getString('name') ?? "";
      _profileImage = sharedPreferences.getString('profileImage') ?? "";
    });
  }

  getAllFavorites() async {
    try {
      return await _controllerLearningObject.getAllFavorites();
    } on DioError catch (e) {
      errorConection(context, () {
        _refreshIndicatorKey.currentState!.show();
      });
      throw e.error!;
    } on IOException catch (e) {
      errorConection(context, () {
        _refreshIndicatorKey.currentState!.show();
      });
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    getAllFavorites();
    super.initState();
  }

  Future _refresh() async {
    getAllFavorites();
    return await getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView(
          children: <Widget>[
            NavBarTop(
              title: "Editar Usuário",
            ),
            Form(
              key: _keyName,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informe os dados que deseja alterar.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.greyDark,
                      ),
                    ),
                    Spacing(padding: 40),
                    Text(
                      'Nome',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.greyDark,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: InputField(
                        title: 'Informe seu nome',
                        obscure: false,
                        controller: _nameController,
                      ),
                    ),
                    Spacing(padding: 40),
                    Button(
                      title: "Atualizar Nome",
                      backgroundColor: AppColors.colorDark,
                      textColor: AppColors.white,
                      onPressed: () async {
                        try {
                          if (_keyName.currentState!.validate()) {
                            await userController.updateProfile(
                              name: _nameController.text,
                            );
                            Navigator.of(context).pop();
                            editConfirm();
                          } else if (_nameController.text.isEmpty) {
                            newEditEmpty();
                          }
                        } catch (e) {
                          if (e == "Erro de conexão") {
                            errorConection(context, () {
                              _refreshIndicatorKey.currentState!.show();
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Form(
              key: _keyPassword,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Senha atual de acesso',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.greyDark,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: InputField(
                        title: 'Digite a sua senha atual de acesso',
                        obscure: false,
                        controller: _oldPasswordController,
                      ),
                    ),
                    Spacing(),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Nova senha de acesso',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.greyDark,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: InputField(
                        title: 'Digite a sua nova senha de acesso',
                        obscure: false,
                        controller: _newPasswordController,
                      ),
                    ),
                    Spacing(),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Confirme a nova senha de acesso',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.greyDark,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: InputField(
                        title: 'Confirme a sua nova senha de acesso',
                        obscure: false,
                        controller: _newPasswordConfirmController,
                      ),
                    ),
                    Spacing(padding: 40),
                    Button(
                      title: "Atualizar Senha",
                      backgroundColor: AppColors.colorDark,
                      textColor: AppColors.white,
                      onPressed: () async {
                        try {
                          if (_keyPassword.currentState!.validate()) {
                            if (await userController.resetPasswordOnly(
                              oldPassword: _oldPasswordController.text,
                              newPassword: _newPasswordController.text,
                              newPasswordConfirm:
                                  _newPasswordConfirmController.text,
                            )) {
                              Navigator.of(context).pop();
                              editConfirm();
                            } else {
                              passwordInvalid();
                            }
                          } else if (_oldPasswordController.text.isEmpty &&
                              _newPasswordController.text.isEmpty &&
                              _newPasswordConfirmController.text.isEmpty) {
                            newEditEmpty();
                          } else {
                            newEditError();
                          }
                        } catch (e) {
                          if (e == "Senhas diferentes") {
                            oldNewPasswordInvalid();
                          } else if (e == "Erro de conexão") {
                            errorConection(context, () {
                              _refreshIndicatorKey.currentState!.show();
                            });
                          }
                        }
                      },
                    ),
                    Spacing(
                      padding: 40,
                    ),
                  ],
                ),
              ),
            ),
            Form(
              key: _keyProfileImage,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Foto de Perfil',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.greyDark,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 8, color: AppColors.white),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: InkWell(
                            onTap: () {
                              var imagePicker = ImagePicker()
                                  .pickImage(source: ImageSource.gallery);

                              imagePicker.then((value) {
                                setState(() {
                                  image = File(value!.path);
                                });
                              });
                            },
                            child: image.path == ""
                                ? CachedNetworkImage(
                                    imageUrl:
                                        AppApi.api + "/user/" + _profileImage,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 120.0,
                                      height: 120.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                      width: 120.0,
                                      height: 120.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                                AssetImage(AppImages.profile),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: 120.0,
                                      height: 120.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                                AssetImage(AppImages.profile),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 120.0,
                                    height: 120.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: FileImage(image),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    Spacing(padding: 40),
                    Button(
                      title: _profileImage == ""
                          ? "Confirmar Foto"
                          : "Atualizar Foto",
                      backgroundColor: AppColors.colorDark,
                      textColor: AppColors.white,
                      onPressed: () async {
                        try {
                          if (_keyProfileImage.currentState!.validate()) {
                            if (await userController.updateProfileImage(
                              image: image,
                            )) {
                              setState(() {
                                _profileImage = image.path;
                              });
                              Navigator.of(context).pop();
                              editConfirm();
                            } else if (image.path.isEmpty) {
                              newImageError();
                            } else {
                              errorEditProfileImage();
                            }
                          } else if (image.path == "") {
                            newImageError();
                          } else {
                            errorEditProfileImage();
                          }
                        } catch (e) {
                          if (e == "File too large") {
                            imageTooLarge();
                          }
                          if (e == "Erro de conexão") {
                            errorConection(context, () {
                              _refreshIndicatorKey.currentState!.show();
                            });
                          }
                        }
                      },
                    ),
                    Spacing(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  errorConection(BuildContext context, Function onPressed) {
    PopUpErrorConnection(context, onPressed: onPressed);
  }

  Future<bool> errorEditProfileImage() async {
    return PopUpMessage(context, "Erro ao editar dados",
            "Erro ao editar seus dados. Tente novamente.") ??
        false;
  }

  Future<bool> editConfirm() async {
    return PopUpMessage(context, "Dados alterados",
            "Seus dados foram modificados com sucesso.") ??
        false;
  }

  Future<bool> passwordInvalid() async {
    return PopUpMessage(context, "Senha inválida",
            "A senha inserida está incorreta. Por favor, informe a senha de acesso atual.") ??
        false;
  }

  Future<bool> oldNewPasswordInvalid() async {
    return PopUpMessage(context, "Senha inválida",
            "A senha e a confirmação de senha não são iguais. Por favor, verifique as senhas inseridas e tente novamente") ??
        false;
  }

  Future<bool> newEditError() async {
    return PopUpMessage(context, "Erro ao editar dados",
            "Para alterar sua senha informe a senha atual, em seguida a nova senha e confirme-a.") ??
        false;
  }

  Future<bool> newImageError() async {
    return PopUpMessage(context, "Erro ao atualizar foto",
            "Nenhuma foto carregada. Por favor, carregue uma foto do perfil.") ??
        false;
  }

  Future<bool> imageTooLarge() async {
    return PopUpMessage(context, "Erro ao atualizar foto",
            "Foto ultrapassa o tamanho estabelecido de 5mb. Por favor, carregue uma nova foto do perfil.") ??
        false;
  }

  Future<bool> newEditEmpty() async {
    return PopUpMessage(context, "Nenhum dado informado",
            "Por favor, informe o dado que deseja modificar.") ??
        false;
  }
}
