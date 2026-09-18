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
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(productCart.imageUrl),
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(productCart.name),
                                        SizedBox(width: 60),
                                        Text(
                                          controller
                                              .precepro(productCart)
                                              .toStringAsFixed(2),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (productCart.quantity == 1) {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Apagar produto?'),
                                        content: const Text(
                                          'Antes de apagar, respire: ao eliminar isto, você pode encerrar uma possibilidade futura.',
                                        ),
                                        icon: Image.network(
                                          'https://vitaminmd.net/wp-content/uploads/2023/06/Unveiling-the-Power-of-Acerola-The-Acerola-Benefits-Vitamin-MD.jpg',
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle: Theme.of(
                                                context,
                                              ).textTheme.labelLarge,
                                            ),
                                            child: const Text('Apagar'),
                                            onPressed: () {
                                              controller.removeProduct(
                                                productCart,
                                              );
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle: Theme.of(
                                                context,
                                              ).textTheme.labelLarge,
                                            ),
                                            child: const Text('Manter'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  controller.decrement(productCart);
                                }
                              },
                              child: Text("-", style: TextStyle(fontSize: 24)),
                            ),
                            SizedBox(width: 8),
                            // Text('teste'),
                            Text(
                              controller.existeProdutoPeloNome(productCart.name)
                                  ? controller.carrinho
                                        .where(
                                          (item) =>
                                              item.name == productCart.name,
                                        )
                                        .first
                                        .quantity
                                        .toString()
                                  : '',
                              style: TextStyle(fontSize: 24),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                controller.increment(productCart);
                              },
                              child: Text("+", style: TextStyle(fontSize: 24)),
                            ),
                            Spacer(),
                          ],
                        ),
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
