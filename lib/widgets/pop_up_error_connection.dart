import 'package:bd_mtur/core/app_colors.dart';
import 'package:bd_mtur/core/app_text_styles.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: non_constant_identifier_names
PopUpErrorConnection(BuildContext context, {Function? onPressed}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Erro de conexão",
            textAlign: TextAlign.center,
            style: AppTextStyles.titleWarning,
          ),
          content: Text(
            "Você está sem acesso a internet. Por favor, verifique sua conexão e tente novamente.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.greyDark,
              fontSize: 16,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          actions: <Widget>[
            Center(
              child: Button(
                title: "Recarregar",
                textColor: AppColors.white,
                backgroundColor: AppColors.colorDark,
                onPressed: () {
                  if (onPressed != null) onPressed();
                  Navigator.of(context).pop(false);
                },
              ),
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.white,
                ),
                onPressed: () {
                  SystemChannels.platform
                      .invokeMethod<void>('SystemNavigator.pop');
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  "Fechar aplicativo",
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
      });
}
