import 'package:bd_mtur/core/app_colors.dart';
import 'package:bd_mtur/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String title;
  final bool obscure;
  final controller;

  InputField({
    required this.title,
    required this.obscure,
    required this.controller,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _passwordVisible = true;

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

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
      style: AppTextStyles.textFormFieldText,
      decoration: InputDecoration(
        labelText: widget.title,
        labelStyle: TextStyle(
          fontSize: 16,
          color: AppColors.greyLightMedium,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.greyLight),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.greyLight,
            width: 1.2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyLight, width: 0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyLight, width: 0),
        ),
        errorStyle: TextStyle(height: 0),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        floatingLabelStyle: TextStyle(
          fontSize: 0,
          color: AppColors.greyLight,
        ),
        suffixIcon: widget.obscure
            ? GestureDetector(
                onTap: _toggle,
                child: Icon(
                  _passwordVisible == true
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: AppColors.greyLight,
                ),
              )
            : SizedBox(),
      ),
      obscureText: widget.obscure ? _passwordVisible : widget.obscure,
    );
  }
}
