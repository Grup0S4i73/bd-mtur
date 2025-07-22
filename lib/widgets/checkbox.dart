// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bd_mtur/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CheckBox extends StatefulWidget {
  Function onTap;

  CheckBox({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return AppColors.colorDark;
      }
      return AppColors.colorDark;
    }

    return SizedBox(
      height: 24.0,
      width: 24.0,
      child: Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isChecked,
        onChanged: (bool? value) {
          widget.onTap();
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}
