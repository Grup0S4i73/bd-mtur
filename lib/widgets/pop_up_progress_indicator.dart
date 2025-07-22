import 'package:flutter/material.dart';
import 'package:bd_mtur/core/app_colors.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';

import '../core/core.dart';

// ignore: non_constant_identifier_names
PopUpProgressIndicator(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Processando",
            textAlign: TextAlign.center,
            style: AppTextStyles.titleWarning,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          actions: <Widget>[
            Column(
              children: [
                GradientProgressIndicator(
                  radius: 90,
                  duration: 1,
                  strokeWidth: 32,
                  gradientStops: const [
                    0.0,
                    1.0,
                  ],
                  gradientColors: [
                    AppColors.colorProgressIndicator,
                    AppColors.colorDark,
                  ],
                  child: Center(),
                ),
                Spacing(
                  padding: 10,
                ),
                Text(
                  "Aguarde...",
                  style: TextStyle(
                    color: AppColors.greyLightMedium,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Spacing(),
            Center(
              child: Button(
                title: "Cancelar",
                textColor: AppColors.white,
                backgroundColor: AppColors.colorDark,
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ),
          ],
        );
      });
}
