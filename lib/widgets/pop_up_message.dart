import 'package:bd_mtur/core/app_text_styles.dart';
import 'package:bd_mtur/core/app_colors.dart';
import 'package:bd_mtur/widgets/button.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
PopUpMessage(BuildContext context, String title, String message) {
  showDialog(
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
          style: AppTextStyles.bodyGrey,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        actions: <Widget>[
          Center(
            child: Button(
                title: "Fechar",
                backgroundColor: AppColors.white,
                textColor: AppColors.colorDark,
                onPressed: () {
                  Navigator.of(context).pop(false);
                }),
          )
        ],
      );
    },
  );
}
