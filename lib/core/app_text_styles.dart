import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:sizer/sizer.dart';

import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle labelTextBox = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.black);

  static final TextStyle bodyGrey =
      GoogleFonts.inter(fontSize: 16, color: AppColors.greyDark);

  static final TextStyle bodyGreySubtitle =
      GoogleFonts.inter(fontSize: 14, color: AppColors.greyDark);

  static final TextStyle labelBoldTextBox = GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.black);

  static final TextStyle linkText =
      GoogleFonts.inter(fontSize: 16, color: AppColors.colorDark);

  static final TextStyle popUpButton =
      GoogleFonts.inter(fontSize: 16, color: AppColors.white);

  static final TextStyle hintTextBox =
      GoogleFonts.inter(fontSize: 16, color: AppColors.greyLight);

  static final TextStyle titleWarning = GoogleFonts.inter(
      fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.greyDark);

  static final TextStyle bodyWarning =
      GoogleFonts.inter(fontSize: 16, color: AppColors.greyDark);

  static final TextStyle messagePopUpRed =
      GoogleFonts.inter(fontSize: 16, color: AppColors.redError);

  static final TextStyle contentTitle = GoogleFonts.inter(
      fontSize: 18, color: AppColors.greyDark, fontWeight: FontWeight.w500);

  static final TextStyle buttonText = GoogleFonts.inter(
      fontSize: 16, color: AppColors.white, fontWeight: FontWeight.w500);

  static final TextStyle labelContentTitleText = GoogleFonts.inter(
      fontSize: 16, color: AppColors.greyDark, fontWeight: FontWeight.bold);

  static final TextStyle labelContentText = GoogleFonts.inter(
      fontSize: 14, color: AppColors.greyDark, fontWeight: FontWeight.w400);

  static final TextStyle labelTabControllerActive = GoogleFonts.inter(
      fontSize: 16, color: AppColors.colorDark, fontWeight: FontWeight.w600);

  static final TextStyle labelTabController = GoogleFonts.inter(
      fontSize: 16, color: AppColors.greyDark, fontWeight: FontWeight.w400);

  static final TextStyle labelContentTextFaded = GoogleFonts.inter(
      fontSize: 14, color: AppColors.greyDark, fontWeight: FontWeight.w400);

  static final TextStyle textFormFieldText = GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: const Color(0xff72777A));
}
