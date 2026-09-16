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

  int quantity;

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
  List<ProductCart> carrinho = [];
  int get itemcarrinho {
    return carrinho.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  //TODO caclular total de preços
  //quantity * price
  // double get subTotal {}

  bool existeProdutoPeloNome(String nome) {
    final nomeLower = nome.toLowerCase();
    return carrinho.any((p) => p.name.toLowerCase() == nomeLower);
  }

  ProductCart? getProductCartByProduct(Product product) {
    return carrinho
        .where((element) => element.name == product.name)
        .firstOrNull;
  }

  ProductCart getProductCartvaid(Product product) {
    return 
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
    if (productCart.quantity < 1)
    notifyListeners();
  }

  void addProduct(Product product) {
    carrinho.add(ProductCart.fromProduct(product));
    notifyListeners();
  }
}
