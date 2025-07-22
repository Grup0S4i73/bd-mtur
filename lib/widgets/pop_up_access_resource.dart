import 'package:bd_mtur/controllers/learning_object_controller.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:bd_mtur/core/app_text_styles.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/app_colors.dart';

// ignore: non_constant_identifier_names

Future<void> recursoVisitado(int? learningObjectID) async {
  final controllerLearningObject = new LearningObjectController();
  if (learningObjectID != null) {
    await controllerLearningObject.setVisited(learningObjectID);
  }
}

_launchLink(String url, int? learningObjectID) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

PopUpAccessResource(
  BuildContext context,
  String format, {
  required LearningObjectModel learningObject,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Abrir link externo",
          textAlign: TextAlign.center,
          style: AppTextStyles.titleWarning,
        ),
        content: Text(
          "Você está prestes a sair do aplicativo e visitar um link externo. Tem certeza que deseja sair desta tela para acessar o link?",
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyGrey,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          Column(
            children: [
              Button(
                title: "Sim, leve-me ao link selecionado",
                backgroundColor: AppColors.colorDark,
                textColor: AppColors.white,
                onPressed: () async {
                  await recursoVisitado(learningObject.id);
                  if (format == "PDF") {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(
                      context,
                      PDFScreen.routeName,
                      arguments: PDFArgumentsScreen(learningObject.urlDownload),
                    );
                  } else {
                    if (format == "Vídeo" &&
                        !learningObject.urlObject.contains('youtu')) {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(
                        context,
                        VideoPlayerContent.routeName,
                        arguments: VideoPlayerContentArgumentsScreen(
                          learningObject,
                        ),
                      );
                    } else {
                      _launchLink(learningObject.urlObject, learningObject.id);
                      Navigator.of(context).pop(false);
                    }
                  }
                },
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: AppColors.white),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  "Fechar",
                  style: TextStyle(
                    color: AppColors.colorDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
