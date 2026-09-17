import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cart/page/cart_page.dart';
import 'package:flutter_application_1/features/home/page/products_by_category_page.dart';
import 'package:flutter_application_1/features/home/page/home_page.dart';
import 'package:flutter_application_1/features/login/pages/login_page.dart';
import 'package:flutter_application_1/features/recover/pages/recover_page.dart';
import 'package:flutter_application_1/features/signup/pages/signup_page.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    LoginPage.route: (context) => LoginPage(),
    SignupPage.route: (context) => SignupPage(),
    RecoverPage.route: (context) => RecoverPage(),
    HomePage.route: (context) => HomePage(),
    ProductsByCategoryPage.route: (context) {
      final String CategoryName =
          ModalRoute.of(context)!.settings.arguments as String;
      return ProductsByCategoryPage(categoryName: CategoryName);
    },
    CartPage.route: (context) => CartPage(),
  };
}
