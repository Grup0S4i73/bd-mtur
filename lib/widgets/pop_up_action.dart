import 'package:bd_mtur/core/app_text_styles.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:flutter/material.dart';

import '../core/app_screens.dart';
import '../core/core.dart';

// ignore: non_constant_identifier_names
PopUpAction(BuildContext context, String title, String message, String option) {
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
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          Column(
            children: [
              Button(
                  title: "Fechar",
                  backgroundColor: AppColors.colorDark,
                  textColor: AppColors.white,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  }),
              Button(
                  title: option,
                  backgroundColor: AppColors.white,
                  textColor: AppColors.colorDark,
                  onPressed: () async {
                    Navigator.pushReplacementNamed(context, "recoverPassword");
                  }),
            ],
          )
        ],
      );
    },
  );
}
