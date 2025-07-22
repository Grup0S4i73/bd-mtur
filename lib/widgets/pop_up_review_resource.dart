import 'package:bd_mtur/core/app_text_styles.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
PopUpReviewResource(
    BuildContext context, String title, String message, String option) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.titleWarning,
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.linkText,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        actions: <Widget>[
          Center(
            child: Button(
              title: option,
              backgroundColor: AppColors.colorDark,
              textColor: AppColors.white,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ),
          Center(
            child: TextButton(
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
          )
        ],
      );
    },
  );
}

errorConection(BuildContext context) async {
  PopUpErrorConnection(context);
}

errorReview(BuildContext context) {
  return PopUpMessage(
    context,
    "Avaliar recurso",
    "Impossível avaliar esse recurso, pois ele já foi avaliado previamente.",
  );
}
