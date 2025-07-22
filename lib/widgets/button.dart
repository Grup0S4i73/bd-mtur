import 'package:bd_mtur/core/app_text_styles.dart';
import 'package:bd_mtur/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Button extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final bool fillText;
  final Function onPressed;

  Button(
      {required this.title,
      required this.backgroundColor,
      required this.textColor,
      required this.onPressed,
      this.fillText = true});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white30, backgroundColor: backgroundColor,
        fixedSize: fillText
            ? Size(getResponsiveWidth(widthScreen) - 40, 60)
            : const Size(double.infinity, double.infinity),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () => this.onPressed(),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
