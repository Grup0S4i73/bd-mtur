import 'package:bd_mtur/core/app_colors.dart';
import 'package:bd_mtur/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ButtonChecked extends StatefulWidget {
  final String title;
  final Function onPressed;
  bool pressed;

  ButtonChecked({
    required this.title,
    required this.onPressed,
    this.pressed = false,
  });

  @override
  State<ButtonChecked> createState() => _ButtonCheckedState();
}

class _ButtonCheckedState extends State<ButtonChecked> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white30, backgroundColor: widget.pressed ? AppColors.colorDark : Colors.white,
          shape: RoundedRectangleBorder(
            side: widget.pressed
                ? BorderSide.none
                : const BorderSide(
                    color: Colors.black,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          widget.onPressed();
        },
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            color: widget.pressed ? AppColors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
