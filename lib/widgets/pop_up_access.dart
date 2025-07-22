import 'package:bd_mtur/controllers/learning_object_controller.dart';
import 'package:bd_mtur/core/app_text_styles.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/app_colors.dart';

Future<void> _launchLink(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

PopUpAccess({
  required BuildContext context,
  required String title,
  required String message,
  required String url,
  String? action,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      final controllerLearningObject = LearningObjectController();

      return AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.titleWarning,
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyGrey,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
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
                  await _launchLink(url);
                  Navigator.of(context).pop(false);
                },
              ),
              action != null
                  ? TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.white,
                      ),
                      onPressed: () async {
                        await _launchLink(url);
                        Navigator.of(context).pop(true);
                      },
                      child: Text(
                        action,
                        style: TextStyle(
                          color: AppColors.colorDark,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Center(),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.white,
                ),
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
