// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late UserController userController;
  late UserModel model;
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String _email = "";
  String _oldPassword = "";

  getUserData() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    setState(() {
      _email = sharedPreference.getString('email') ?? "";
      _oldPassword = sharedPreference.getString('password') ?? "";
    });
  }

  @override
  void initState() {
    getUserData();
    setState(() {
      userController = new UserController();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: NavBarTop(
          title: "Recuperar Senha",
        ),
      ),
      body: Form(
        key: _key,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Informe uma nova senha.",
                    style: TextStyle(
                      color: AppColors.greyDark,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Informe uma nova senha',
                      style: TextStyle(
                        color: AppColors.greyDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  InputField(
                    title: 'Digite a sua nova senha de acesso',
                    controller: _passwordController,
                    obscure: true,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Confirme a nova senha',
                      style: TextStyle(
                        color: AppColors.greyDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  InputField(
                    title: 'Confirme a sua nova senha de acesso',
                    controller: _passwordConfirmController,
                    obscure: true,
                  ),
                  Spacing(),
                  Button(
                      title: 'Cadastrar Nova Senha',
                      backgroundColor: AppColors.colorDark,
                      textColor: Colors.white,
                      onPressed: () async {
                        try {
                          if (_key.currentState!.validate()) {
                            if (await userController.resetPassword(
                              email: _email.trim(),
                              password: _passwordController.text.trim(),
                              passwordConfirm:
                                  _passwordConfirmController.text.trim(),
                            )) {
                              Navigator.pushReplacementNamed(context, "login");
                              successUpdate();
                            } else {
                              errorUpdatePasswordInvalid();
                            }
                          } else if ((_passwordController.text == "") ||
                              (_passwordConfirmController.text == "")) {
                            errorUpdateNoData();
                          }
                        } catch (e) {
                          if (e == "Erro de conexão") {
                            errorUpdateNoConnection();
                          } else if (e == "Senhas diferentes") {
                            errorUpdatePasswordConfirm();
                          }
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> errorUpdate() async {
    return PopUpMessage(context, "Erro ao atualizar a senha",
        "Realize o procedimento novamente para recuperar sua senha.");
  }

  Future<void> errorUpdatePasswordConfirm() async {
    return PopUpMessage(context, "Senha inválida",
        "A senha e a confirmação de senha não são iguais. Por favor, verifique as senhas inseridas e tente novamente.");
  }

  Future<void> errorUpdatePasswordInvalid() async {
    return PopUpMessage(context, "Senha inválida",
        "A senha é igual a anterior. Por favor, insira uma senha nova diferente da anterior.");
  }

  Future<void> errorUpdateNoData() async {
    return PopUpMessage(context, "Erro ao recuperar senha",
        "Dados obrigatórios para a recuperação da senha não preenchidos. Por favor, informe sua nova senha de acesso e confirme.");
  }

  Future<void> errorUpdateNoConnection() async {
    return PopUpErrorConnection(context);
  }

  Future<void> successUpdate() async {
    return PopUpMessage(context, "Senha alterada",
        "A sua senha foi alterada com sucesso. Por favor, faça o login novamente.");
  }
}
