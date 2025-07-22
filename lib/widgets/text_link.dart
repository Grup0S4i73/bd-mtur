import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../core/app_colors.dart';

class TextLink extends StatelessWidget {
  final String title;
  final Function onPressed;

  TextLink({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white30, backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onPressed: () => this.onPressed(),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: AppColors.colorDark,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
