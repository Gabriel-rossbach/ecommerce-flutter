import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/models/products_model.dart';

class ProductCart extends Product {
  ProductCart({
    required super.brand,
    required super.name,
    required super.imageUrl,
    required super.price,
    required super.category,
    required super.description,
    required this.quantity,
  });

  int quantity = 0;

  factory ProductCart.fromProduct(Product product) {
    return ProductCart(
      brand: product.brand,
      name: product.name,
      imageUrl: product.imageUrl,
      price: product.price,
      category: product.category,
      description: product.description,
      quantity: 1,
    );
  }
}

class CartController extends ChangeNotifier {
  int pageViewIndex = 0;
  List<ProductCart> carrinho = [];
  int get itemcarrinho {
    return carrinho.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  double prece = 0;
  double precepro(Product product) {
    ProductCart? productCart = getProductCartByProduct(product);
    if (productCart != null) {
      prece = productCart.quantity * productCart.price;
      notifyListeners();
      return prece;
    }
    notifyListeners();
    return 0;
  }

  //TODO caclular total de preços
  //quantity * price
  // double get subTotal {}
  void changePageViewIndex(int index) {
    pageViewIndex = index;
    notifyListeners();
  }

  bool existeProdutoPeloNome(String nome) {
    final nomeLower = nome.toLowerCase();
    return carrinho.any((p) => p.name.toLowerCase() == nomeLower);
  }

  ProductCart? getProductCartByProduct(Product product) {
    return carrinho
        .where((element) => element.name == product.name)
        .firstOrNull;
  }

  ProductCart? getProductCartVoid(ProductCart product) {
    return carrinho
        .where((element) => element.quantity == 0 && product.quantity == 0)
        .firstOrNull;
  }

  void increment(Product product) {
    ProductCart? productCart = getProductCartByProduct(product);
    if (productCart != null) {
      productCart.quantity++;
      carrinho[carrinho.indexOf(productCart)] = productCart;
    }
    notifyListeners();
  }

  void decrement(Product product) {
    ProductCart? productCart = getProductCartByProduct(product);
    if (productCart != null) {
      productCart.quantity--;
      carrinho[carrinho.indexOf(productCart)] = productCart;
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    ProductCart? productCart = getProductCartByProduct(product);
    if (productCart != null) {
      carrinho.remove(productCart);
    }
    notifyListeners();
  }

  void addProduct(Product product) {
    carrinho.add(ProductCart.fromProduct(product));
    notifyListeners();
  }
}
