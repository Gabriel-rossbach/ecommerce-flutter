import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/app_colors.dart';
import 'package:flutter_application_1/shared/app_text_style.dart';

enum ButtonType { filled, outlined }

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.buttonText,
    required this.type,
    required this.onPressed,
    this.isLoading = false,
  });
  final String buttonText;
  final ButtonType type;
  final Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: type == ButtonType.filled
          ? ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(40),
              backgroundColor: AppColors.black,
              foregroundColor: AppColors.white,

              textStyle: AppTextStyle.buttonLabel,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            )
          : ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(40),
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,

              textStyle: AppTextStyle.buttonLabel,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: type == ButtonType.filled
                    ? AppColors.white
                    : AppColors.black,
              ),
            )
          : Text(buttonText),
    );
  }
}
