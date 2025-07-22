import 'dart:async';

import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/models/user_model.dart';
import 'package:bd_mtur/widgets/pop_up_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late UserController userController;
  late UserModel user;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool keepLogin = false;

  @override
  void initState() {
    userController = UserController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                  child: Align(
                    child: Image(
                      image: AssetImage(AppIcons.logo),
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Align(
                    child: Text(
                      "BIBLIOTECA DIGITAL",
                      style: TextStyle(
                        color: AppColors.greyDark,
                        fontFamily: 'BebasNeue',
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Align(
                    child: Text(
                      "Turismo Acessível".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.colorDark,
                        fontFamily: 'BebasNeue',
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Email',
                          style: AppTextStyles.labelContentTitleText,
                        ),
                      ),
                      InputField(
                        title: 'Digite seu email de usuário UNASUS',
                        controller: _emailController,
                        obscure: false,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          'Senha',
                          style: AppTextStyles.labelContentTitleText,
                        ),
                      ),
                      InputField(
                        title: 'Digite a sua senha de acesso',
                        controller: _passwordController,
                        obscure: true,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Button(
                          title: "Entrar",
                          backgroundColor: AppColors.colorDark,
                          textColor: AppColors.white,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                if (await userController.login(
                                  _emailController.text,
                                  _passwordController.text,
                                  keepLogin,
                                )) {
                                  progressIndicatorPopUp();
                                  Timer(Duration(seconds: 1), () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      "/home",
                                    );
                                  });
                                }
                              } catch (e) {
                                if (e.toString().contains("Senha incorreta")) {
                                  errorLogin();
                                } else if (e.toString().contains(
                                  "Usuário não existe",
                                )) {
                                  errorLogin();
                                } else {
                                  errorLoginNoConnection();
                                }
                              }
                            } else if ((_emailController.text == "") ||
                                (_passwordController.text == "")) {
                              errorLoginNoData();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CheckBox(
                            onTap: () {
                              setState(() {
                                keepLogin = !keepLogin;
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Manter logado',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "recoverPassword");
                        },
                        child: Text(
                          'Esqueci a senha',
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
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: const Text(
                          'Não possui uma conta?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: Register(),
                            ),
                          );
                        },
                        child: Text(
                          'Cadastre-se',
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
                ) /*
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Divider(
                          color: Color(0xffC6C6C6),
                          thickness: 1,
                          endIndent: 0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'OU',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color(0xffC6C6C6),
                          thickness: 1,
                          endIndent: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: GoogleButton.transparent(
                        label: "Login com Google",
                        onTap: () {},
                      ),
                    ),
                  ],
                ),*/,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> errorLogin() async {
    return PopUpMessage(
          context,
          "Erro ao logar",
          "E-mail e/ou senha incorretos. Por favor, informe o e-mail e a senha de acesso.",
        ) ??
        false;
  }

  Future<bool> errorLoginNoData() async {
    return PopUpMessage(
          context,
          "Erro ao logar",
          "Dados obrigatórios de acesso não preenchidos. Por favor, informe o e-mail e a senha de acesso.",
        ) ??
        false;
  }

  Future<bool> errorLoginNoConnection() async {
    return PopUpErrorConnection(context) ?? false;
  }

  Future<void> progressIndicatorPopUp() async {
    return PopUpProgressIndicator(context);
  }
}
