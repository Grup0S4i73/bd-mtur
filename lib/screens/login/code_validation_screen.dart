// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/pop_up_progress_indicator.dart';

class CodeValidation extends StatefulWidget {
  const CodeValidation({Key? key}) : super(key: key);

  @override
  State<CodeValidation> createState() => _CodeValidationState();
}

class _CodeValidationState extends State<CodeValidation> {
  late UserController userController;
  late UserModel model;
  final _codeController = TextEditingController();
  final _emailController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String _email = "";

  getUserEmail() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    setState(() {
      _email = sharedPreference.getString('email') ?? "";
    });
  }

  @override
  void initState() {
    getUserEmail();
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
                    "O e-mail foi enviado com sucesso. Por favor, verifique o seu e-mail e informe o código para alterar a senha. Obs. Não se esqueça de verificar a sua caixa de spam, caso não encontre o e-mail.",
                    style: TextStyle(
                      color: AppColors.greyDark,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Código de Verificação',
                      style: TextStyle(
                        color: AppColors.greyDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  InputField(
                    title: 'Digite o código de verificação',
                    controller: _codeController,
                    obscure: false,
                  ),
                  Spacing(),
                  Button(
                      title: 'Confirmar código',
                      backgroundColor: AppColors.colorDark,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          try {
                            if (await userController.codeValidation(
                                _email, _codeController.text)) {
                              progressIndicatorPopUp();
                              Timer(Duration(seconds: 1), () {
                                Navigator.pushReplacementNamed(
                                    context, "resetPassword");
                              });
                            }
                          } catch (e) {
                            if (e == "Código inválido.") {
                              errorCode();
                            } else if (e == SocketException) {
                              errorCodeNoConnection();
                            }
                          }
                        } else if (_codeController.text == "") {
                          errorCodeNoData();
                        }
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Não recebeu o código?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            if (await userController.resendEmail(_email)) {
                              progressIndicatorPopUp();
                              Timer(Duration(seconds: 1), () {
                                Navigator.of(context).pop();
                                resendSuccess();
                              });
                            }
                          } catch (e) {
                            if (e == "Código inválido.") {
                            } else if (e == SocketException) {
                              errorCodeNoConnection();
                            }
                          }
                        },
                        child: Text(
                          'Enviar novamente?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.colorDark,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> errorCode() async {
    return PopUpMessage(context, "Código inválido",
        "Por favor, informe o código de recuperação enviado ao e-mail para o qual deseja recuperar a senha.");
  }

  Future<void> errorCodeNoData() async {
    return PopUpMessage(context, "Código não informado",
        "Por favor, informe o código de recuperação enviado ao e-mail para o qual deseja recuperar a senha.");
  }

  Future<void> resendSuccess() async {
    return PopUpMessage(context, "Código enviado",
        "Um novo código foi enviado para o seu e-mail.");
  }

  Future<void> errorCodeNoConnection() async {
    return PopUpErrorConnection(context);
  }

  Future<void> progressIndicatorPopUp() async {
    return PopUpProgressIndicator(context);
  }
}
