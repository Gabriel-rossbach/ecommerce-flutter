import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cart/controllers/cart_controller.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static String route = '/cart';

  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Consumer<CartController>(
        builder: (context, controller, child) {
          return Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 157,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      controller.changePageViewIndex(value);
                    },
                    itemCount: controller.carrinho.length,
                    scrollDirection: Axis.horizontal,
                    pageSnapping: true,
                    itemBuilder: (context, pagePosition) {
                      final productCart = controller.carrinho[pagePosition];

                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: Image.network(productCart.imageUrl),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
