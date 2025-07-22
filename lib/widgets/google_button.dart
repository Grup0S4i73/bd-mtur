import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color fontColor;
  final Color overlayColor;
  final Color borderColor;
  final VoidCallback onTap;

  const GoogleButton({
    required Key key,
    required this.label,
    required this.backgroundColor,
    required this.fontColor,
    required this.overlayColor,
    required this.onTap,
    required this.borderColor,
  }) : super(key: key);

  GoogleButton.success({required String label, required VoidCallback onTap})
      : this.backgroundColor = AppColors.colorDark,
        this.fontColor = Colors.white,
        this.overlayColor = AppColors.greyDark,
        this.borderColor = Colors.transparent,
        this.onTap = onTap,
        this.label = label;

  GoogleButton.transparent({required String label, required VoidCallback onTap})
      : this.backgroundColor = Colors.transparent,
        this.fontColor = AppColors.black,
        this.overlayColor = AppColors.greyLight,
        this.borderColor = AppColors.greyLight,
        this.onTap = onTap,
        this.label = label;

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return Container(
      height: 50,
      width: getResponsiveWidth(widthScreen) - 40,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          side: WidgetStateProperty.all(BorderSide(color: borderColor)),
          overlayColor: WidgetStateProperty.all(overlayColor),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Image.asset(AppImages.google, width: 35),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60.0, 0, 0, 0),
              child: Text(
                label,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: fontColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
