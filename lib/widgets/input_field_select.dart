// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:bd_mtur/core/app_colors.dart';

class InputFieldSelect extends StatefulWidget {
  final List<DropdownMenuItem<String>> list;
  String initialValue;
  String title;
  Function onChanged;

  InputFieldSelect({
    Key? key,
    required this.list,
    required this.initialValue,
    required this.title,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<InputFieldSelect> createState() => _InputFieldSelectState();
}

class _InputFieldSelectState extends State<InputFieldSelect> {
  String selectedState = "";
  int selectedStateid = 0;
  String selectedCity = "";

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: widget.initialValue,
      style: TextStyle(
        fontSize: 16,
        color: AppColors.greyLightMedium,
        overflow: TextOverflow.ellipsis,
      ),
      onChanged: (String? newValue) {
        widget.onChanged(newValue);
        setState(() {
          widget.initialValue = newValue!;
        });
      },
      items: widget.list,
      decoration: InputDecoration(
        hintText: widget.title,
        hintStyle: TextStyle(
          fontSize: 16,
          color: AppColors.greyLightMedium,
          overflow: TextOverflow.ellipsis,
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
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.greyLight,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyLight, width: 0),
        ),
        errorStyle: TextStyle(height: 0),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        floatingLabelStyle: TextStyle(fontSize: 0, color: AppColors.greyLight),
      ),
    );
  }
}
