import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/models/category_model.dart';
import 'package:flutter_application_1/features/home/models/products_model.dart';
import 'package:flutter_application_1/shared/mocks.dart';

enum CategoriesViewState { loading, success, erros }

enum productsViewState { loading, success, erros }

class HomeController extends ChangeNotifier {
  List<Category> categories = [];
  List<Product> products = [];
  List<String> carrinho = [];
  int intemcarrinho = 1;
  int pageViewIndex = 0;
  CategoriesViewState categoriesState = CategoriesViewState.loading;
  productsViewState productsState = productsViewState.loading;
  List<String> images = [
    'assets/images/Banner.png',
    'assets/images/Banner2.png',
  ];
  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(2),
        width: 10,
        height: 9,
        decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle,
        ),
      );
    });
  }

  void changePageViewIndex(int index) {
    pageViewIndex = index;
    notifyListeners();
  }

  void changeCategoriesState(CategoriesViewState state) {
    categoriesState = state;
    notifyListeners();
  }

  void changeproductsState(productsViewState state) {
    productsState = state;
    notifyListeners();
  }

  Future<void> getCategories() async {
    changeCategoriesState(CategoriesViewState.loading);
    await Future.delayed(Duration(seconds: 3));
    try {
      // categories = [
      //   for (var element in categoriesJson) Category.fromJson(element),
      // ];
      categories = categoriesJson.map((item) {
        return Category.fromJson(item);
      }).toList();

      changeCategoriesState(CategoriesViewState.success);
    } catch (e) {
      changeCategoriesState(CategoriesViewState.erros);
    }
  }

  void increment() {
    intemcarrinho++;
    notifyListeners();
  }

  void decrement() {
    if (intemcarrinho > 0) {
      intemcarrinho--;
      notifyListeners();
    }
  }

  Future<void> getproducts() async {
    changeproductsState(productsViewState.loading);
    await Future.delayed(Duration(seconds: 3));
    try {
      products = productsJson.map((item) {
        return Product.fromJson(item);
      }).toList();
      changeproductsState(productsViewState.success);
    } catch (e) {
      changeproductsState(productsViewState.erros);
    }
  }
}
