import 'package:bd_mtur/core/app_text_styles.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
CloseDialogWidget(BuildContext context, String title, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.labelBoldTextBox,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(children: [
              Text(
                message,
                textAlign: TextAlign.center,
              ),
            ]),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: Text(
                  "Fechar",
                  style: AppTextStyles.linkText,
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            )
          ],
        );
      });
}
