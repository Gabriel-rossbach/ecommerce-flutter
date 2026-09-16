import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/app_colors.dart';

class AppTextStyle {
  static TextStyle get title => TextStyle(
    color: AppColors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get corpoTitle =>
      TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
  static TextStyle get buttonLabel => TextStyle(
    color: AppColors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get smallGrey =>
      TextStyle(fontWeight: FontWeight.w500, color: AppColors.grey);

  static TextStyle get smallGreen =>
      TextStyle(fontWeight: FontWeight.w500, color: AppColors.green);
  static TextStyle get smallBlack =>
      TextStyle(fontWeight: FontWeight.w500, color: AppColors.black);
}
