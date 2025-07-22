import 'dart:io';

import 'package:flutter/material.dart';

import 'package:bd_mtur/core/app_colors.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/app_text_styles.dart';
import 'package:image_picker/image_picker.dart';

class ImageField extends FormField {
  ImageField({
    BuildContext? context,
    FormFieldSetter? onSaved,
    FormFieldValidator? validator,
    XFile? initialValue,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (state) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context!,
                  builder: (context) => ImageSourceSheet(
                    onImageSelected: (image) {
                      state.didChange(image);
                    },
                  ),
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(state.value!.path),
                backgroundColor: AppColors.white,
                maxRadius: 50,
              ),
            );
          },
        );
}
