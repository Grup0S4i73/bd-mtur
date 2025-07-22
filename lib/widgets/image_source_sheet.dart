import 'dart:io';

import 'package:bd_mtur/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(XFile) onImageSelected;

  const ImageSourceSheet({Key? key, required this.onImageSelected})
      : super(key: key);

  void imageSelected(XFile? image) async {
    if (image != null) {
      onImageSelected(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Column(
        children: [
          TextButton(
            child: Text(
              "Câmera",
              style: TextStyle(
                color: AppColors.colorDark,
                fontSize: 16,
              ),
            ),
            onPressed: () async {
              XFile? image =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              imageSelected(image);
            },
          ),
          TextButton(
            child: Text(
              "Galeria",
              style: TextStyle(
                color: AppColors.colorDark,
                fontSize: 16,
              ),
            ),
            onPressed: () async {
              XFile? image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              imageSelected(image);
            },
          ),
        ],
      ),
    );
  }
}
