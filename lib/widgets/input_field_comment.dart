import 'package:bd_mtur/core/app_colors.dart';
import 'package:bd_mtur/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class InputFieldComment extends StatefulWidget {
  final TextEditingController controller;
  final Function sendComment;

  InputFieldComment({
    required this.controller,
    required this.sendComment,
  });

  @override
  State<InputFieldComment> createState() => _InputFieldCommentState();
}

class _InputFieldCommentState extends State<InputFieldComment> {
  bool textFieldIsEmpty = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '';
        }
        return null;
      },
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() {
            textFieldIsEmpty = true;
          });
        } else {
          setState(() {
            textFieldIsEmpty = false;
          });
        }
      },
      style: AppTextStyles.textFormFieldText,
      decoration: InputDecoration(
        labelText: "Adicionar um comentário público...",
        labelStyle: AppTextStyles.bodyGrey,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.white,
          width: 0,
        )),
        contentPadding: EdgeInsets.all(1),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white, width: 0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white, width: 0)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white, width: 0)),
        errorStyle: TextStyle(height: 0),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        floatingLabelStyle: TextStyle(fontSize: 0, color: AppColors.white),
        suffixIcon: GestureDetector(
          onTap: () {
            if (widget.controller.text.isNotEmpty) {
              widget.sendComment();
              setState(() {
                widget.controller.text = '';
                textFieldIsEmpty = true;
              });
            }
          },
          child: Icon(
            Icons.send,
            color: textFieldIsEmpty ? AppColors.greyLight : AppColors.colorDark,
          ),
        ),
      ),
    );
  }
}
