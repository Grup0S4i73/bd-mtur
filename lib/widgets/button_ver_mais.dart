import 'package:bd_mtur/core/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonVerMais extends StatelessWidget {
  final Future onPressed;

  ButtonVerMais({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.colorDark,
      ),
      height: 32,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white30, backgroundColor: AppColors.colorDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: () => this.onPressed,
          child: const Text(
            "Ver mais",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
