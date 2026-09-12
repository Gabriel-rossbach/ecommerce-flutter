import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/controllers/home_controller.dart';
import 'package:flutter_application_1/shared/app_colors.dart';
import 'package:flutter_application_1/shared/app_text_style.dart';

class AppButtonProducts extends StatelessWidget {
  AppButtonProducts({super.key, this.onPressed});
  final HomeController intemcarrinho = HomeController();
  final int value = 1;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('Adicionar ao carrinho'),
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(40),
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,

        textStyle: AppTextStyle.buttonLebel,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
