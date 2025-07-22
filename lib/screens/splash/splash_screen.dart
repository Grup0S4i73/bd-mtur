import 'dart:async';
import 'dart:io';

import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late UserController userController;

  initState() {
    super.initState();

    userController = UserController();
    Future.delayed(Duration(seconds: 2), () {
      redirectToHome();
    });
  }

  redirectToHome() async {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        alignment: Alignment.center,
        duration: Duration(seconds: 1),
        reverseDuration: Duration(seconds: 1),
        opaque: true,
        curve: Curves.easeIn,
        child: Home(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/app/logo_splash.png',
                width: getResponsiveWidth(widthScreen) * 0.8,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/app/logo_splash_bottom.png',
                width: getResponsiveWidth(widthScreen) * 1,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
