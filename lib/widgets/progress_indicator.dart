import 'package:flutter/material.dart';
import 'package:bd_mtur/core/app_colors.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';

class ProgressBarIndicator extends StatefulWidget {
  const ProgressBarIndicator({Key? key}) : super(key: key);

  @override
  State<ProgressBarIndicator> createState() => _ProgressBarIndicatorState();
}

class _ProgressBarIndicatorState extends State<ProgressBarIndicator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
            "Carregando...",
            style: TextStyle(
              color: AppColors.greyLightMedium,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
