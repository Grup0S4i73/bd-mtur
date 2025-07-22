// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/app_screens.dart';

import '../../widgets/pop_up_progress_indicator.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({Key? key}) : super(key: key);

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  late UserController userController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void initState() {
    userController = UserController();
    super.initState();
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
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Informe seu email para receber o código e criar uma nova senha.",
                    style: TextStyle(
                      color: AppColors.greyDark,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Email',
                      style: TextStyle(
                        color: AppColors.greyDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  InputField(
                    title: 'Digite o e-mail cadastrado na UNASUS',
                    controller: _emailController,
                    obscure: false,
                  ),
                  Spacing(),
                  Button(
                      title: 'Validar e-mail',
                      backgroundColor: AppColors.colorDark,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String email = _emailController.text
                              .trim()
                              .replaceAll(RegExp(' '), '');
                          try {
                            if (await userController.sendEmail(email)) {
                              progressIndicatorPopUp();
                              Timer(Duration(seconds: 1), () {
                                Navigator.pushReplacementNamed(
                                    context, "codeValidation");
                              });
                            }
                          } catch (e) {
                            if (e == "Usuário não existe") {
                              errorRecover();
                            } else if (e == SocketException) {
                              errorRecoverNoConnection();
                            }
                          }
                        } else if (_emailController.text == "") {
                          errorRecoverNoData();
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

  Future<void> errorRecover() async {
    return PopUpMessage(context, "E-mail inválido",
        "O e-mail informado não está cadastrado no sistema. Informe um e-mail válido");
  }

  Future<void> errorRecoverNoData() async {
    return PopUpMessage(context, "E-mail não informado",
        "Por favor, informe o e-mail de acesso para o qual deseja recuperar a senha.");
  }

  Future<void> errorRecoverNoConnection() async {
    return PopUpErrorConnection(context);
  }

  Future<void> progressIndicatorPopUp() async {
    return PopUpProgressIndicator(context);
  }
}
