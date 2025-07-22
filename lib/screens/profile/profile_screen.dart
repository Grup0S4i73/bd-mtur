import 'dart:io';

import 'package:bd_mtur/controllers/learning_object_controller.dart';
import 'package:bd_mtur/controllers/theme_controller.dart';
import 'package:bd_mtur/widgets/pop_up_action.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/app_api.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:bd_mtur/core/app_widgets.dart';

import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/models/user_model.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final UserController userController = new UserController();
  final learningObjectController = LearningObjectController();

  bool? isLoggedHere;
  bool controlScreenProfile = false;
  String _name = "";
  String _profileImage = "";

  getUser() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    setState(() {
      _name = sharedPreference.getString('name') ?? "";
      _profileImage = sharedPreference.getString('profileImage') ?? "";
    });
  }

  getStatusConquest() async {
    try {
      final resources =
          await learningObjectController.getAllEducationalObject();
      final resources_visited = await learningObjectController.getAllVisited();

      setState(() {
        userController.amount_resources = resources.length;
        userController.amount_resources_visited = resources_visited.length;
        if (userController.amount_resources == 0) {
          userController.statusConquest = 0;
        } else {
          userController.statusConquest = (userController
                  .amount_resources_visited /
              userController.amount_resources); // Status do consumo de recursos
        }

        if (userController.statusConquest == 0)
          userController.level = 0;
        else if (userController.statusConquest > 0 &&
            userController.statusConquest <= 0.24)
          userController.level = 1;
        else if (userController.statusConquest >= 0.25 &&
            userController.statusConquest <= 0.49)
          userController.level = 2;
        else if (userController.statusConquest >= 0.5 &&
            userController.statusConquest <= 0.74)
          userController.level = 3;
        else if (userController.statusConquest >= 0.75 &&
            userController.statusConquest <= 0.99)
          userController.level = 4;
        else if (userController.statusConquest == 1) userController.level = 5;

        controlScreenProfile = true;
      });
    } on DioException catch (e) {
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

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    var verifyToken = await userController.verifyToken();

    return token != null && verifyToken;
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus().then((isLogged) {
      if (isLogged) {
        setState(() {
          isLoggedHere = true;
        });
        getUser();
        getStatusConquest();
      } else {
        setState(() {
          isLoggedHere = false;
        });
      }
    });
    setState(() {
      controlScreenProfile = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    checkLoginStatus().then((isLogged) {
      if (isLogged) {
        getUser();
        getStatusConquest();
      }
    });
    setState(() {
      controlScreenProfile = false;
    });
  }

  Future _refresh() async {
    setState(() {
      controlScreenProfile = false;
    });
    getUser();
    return await getStatusConquest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView(
          children: isLoggedHere != null
              ? isLoggedHere!
                  ? controlScreenProfile
                      ? [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 40, horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _imageProfile(),
                                _editProfile(),
                                Spacing(),
                                _levelSection(),
                                Spacing(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Conquistas",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.colorDark,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacing(),
                                userController.statusConquest < 0.25
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Nenhuma conquista alcançada",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.greyDark),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                userController.statusConquest >=
                                        1.0 //100% dos recursos consumidos
                                    ? _itemConquista(
                                        text: "Você consumiu 100% dos recursos",
                                        date: "-")
                                    : Container(),
                                userController.statusConquest >=
                                        0.75 //75% dos recursos consumidos
                                    ? _itemConquista(
                                        text: "Você consumiu 75% dos recursos",
                                        date: "-")
                                    : Container(),
                                userController.statusConquest >=
                                        0.50 //50% dos recursos consumidos
                                    ? _itemConquista(
                                        text: "Você consumiu 50% dos recursos",
                                        date: "-")
                                    : Container(),
                                userController.statusConquest >=
                                        0.25 //25% dos recursos consumidos
                                    ? _itemConquista(
                                        text: "Você consumiu 25% dos recursos",
                                        date: "-")
                                    : Container(),
                                Spacing(),
                                _deleteAccountButton(),
                                Spacing(),
                                _sairButton()
                              ],
                            ),
                          ),
                        ]
                      : [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: Center(),
                              ),
                              ProgressBarIndicator(),
                              Spacing(),
                              _deleteAccountButton(),
                              Spacing(),
                              _sairButton()
                            ],
                          ),
                        ]
                  : [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Center(),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Faça login para acessar essa parte",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.greyDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Button(
                            title: "Fazer Login",
                            backgroundColor: AppColors.colorDark,
                            textColor: AppColors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const Login(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ]
              : [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Center(),
                      ),
                      ProgressBarIndicator(),
                    ],
                  ),
                ],
        ),
      ),
    );
  }

  _itemConquista({required String text, required String date}) {
    var checkIcon = Icon(
      Icons.check_circle_outline,
      color: AppColors.colorDark,
      size: 40,
    );

    var title = Text(
      text,
      style: TextStyle(
        color: AppColors.colorDark,
        fontSize: 16,
      ),
    );

    var subtitle = Text(
      date,
      style: TextStyle(
        color: AppColors.greyLightMedium,
        fontSize: 14,
      ),
    );
    return ListTile(
      leading: checkIcon,
      title: title,
      subtitle: subtitle,
    );
  }

  _deleteAccountButton() {
    return _button(
        title: "Deletar conta",
        onPressed: () async {
          await popUpDeleteUser();
          _backToHome();
        });
  }

  _sairButton() {
    return _button(
        title: "Sair do sistema",
        onPressed: () async {
          await userController.logout();
          _backToHome();
        });
  }

  _button({required String title, required Function onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Button(
            title: title,
            backgroundColor: AppColors.colorDark,
            textColor: AppColors.white,
            onPressed: () async => await onPressed()),
      ],
    );
  }

  _backToHome() =>
      Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);

  errorConection(BuildContext context, Function onPressed) {
    PopUpErrorConnection(context, onPressed: onPressed);
  }

  popUpEvaluationSucess(BuildContext context) {
    PopUpMessage(
      context,
      "Conta deletada",
      "Conta deletada com sucesso!",
    );
  }

  popUpDeleteUser() async {
    return PopUpReviewResource(
      context,
      "Deletar Conta",
      "Você está prestes a deletar sua conta. Tem certeza que deseja deletar sua conta?",
      "Deletar",
    ).then((popup_value) async {
      if (popup_value) {
        try {
          await userController.deleteUser().then((value) {
            if (value != null) {
              popUpEvaluationSucess(context);
            }
            return value;
          });
        } catch (e) {
          if (e == "Erro de conexão") {
            errorConection(context, () {
              _refreshIndicatorKey.currentState!.show();
            });
          }
        }
      }
    });
  }

  _imageProfile() {
    var defaultImage = Container(
      width: 120.0,
      height: 120.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage(AppImages.profile), fit: BoxFit.cover),
      ),
    );

    var decoration = BoxDecoration(
      border: Border.all(width: 8, color: AppColors.white),
      borderRadius: BorderRadius.circular(100),
    );
    return Container(
      decoration: decoration,
      child: CachedNetworkImage(
        imageUrl: AppApi.api + "/user/" + _profileImage,
        imageBuilder: (context, imageProvider) => Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        errorWidget: (context, url, error) => defaultImage,
      ),
    );
  }

  _editProfile() {
    var style = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.colorDark,
    );
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => _navigateToProfile(),
            icon: Icon(
              Icons.edit,
              color: AppColors.colorDark,
            ),
          ),
          Flexible(
            child: Text(
              _name,
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
        ],
      ),
    );
  }

  _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfile(),
      ),
    ).then((_) {
      setState(() {
        getUser();
        getStatusConquest();
      });
    });
  }

  _levelSection() {
    var decorate = BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: AppColors.colorDark);

    return Container(
      decoration: decorate,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _iconNumber(
                text: userController.amount_resources_visited.toString(),
                progress: 0,
                legenda: "Total de Recursos\nConsumidos",
              ),
              _iconNumber(
                text: userController.level.toString(),
                progress: userController.statusConquest,
                legenda: "Nível\n",
              )
            ],
          )),
    );
  }

  _iconNumber(
      {required String text,
      required String legenda,
      required double progress}) {
    var textStyle = TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    );

    var legendaStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    );
    var content = Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: CircularStepProgressIndicator(
        totalSteps: 100,
        currentStep: (progress * 100).toInt(),
        selectedColor: AppColors.white,
        unselectedColor: AppColors.colorDark,
        padding: 0,
        width: 60,
        height: 60,
        child: CircleAvatar(
            backgroundColor: AppColors.colorDark,
            child: Text(text, textAlign: TextAlign.center, style: textStyle)),
      ),
    );

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          content,
          Text(
            legenda,
            textAlign: TextAlign.center,
            style: legendaStyle,
          )
        ]);
  }
}
