import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cart/controllers/cart_controller.dart';
import 'package:flutter_application_1/features/home/controllers/home_controller.dart';
import 'package:flutter_application_1/features/home/models/products_model.dart';
import 'package:flutter_application_1/shared/app_colors.dart';
import 'package:flutter_application_1/shared/app_text_style.dart';
import 'package:flutter_application_1/shared/widget/app_button_products.dart';
import 'package:flutter_application_1/shared/widget/app_elevated_button.dart';
import 'package:provider/provider.dart';

import 'package:skeletonizer/skeletonizer.dart';

class ProductCard extends StatelessWidget {
  ProductCard({super.key, required this.product});

  final Product product;

  final HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () async {
            print('clicou no produto ${product.name}');
            var result = await showModalBottomSheet(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              builder: (context) {
                return ProductBottomSheet(product: product);
              },
            );
            print(result);
            if (result != null) {
            } else {}
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Skeleton.replace(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(product.imageUrl, fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(product.brand, style: AppTextStyle.smallGrey),
              Text(product.name, style: AppTextStyle.smallBlack),
              Text(
                '\$${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                style: AppTextStyle.smallGreen,
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProductBottomSheet extends StatelessWidget {
  const ProductBottomSheet({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, controller, child) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(product.imageUrl, fit: BoxFit.fill),
                ),
              ),
              Text(product.name, style: AppTextStyle.title),
              SizedBox(height: 20, width: 892),
              Text(product.brand, style: AppTextStyle.smallGrey),
              SizedBox(height: 20, width: 892),
              Text(product.description, style: AppTextStyle.corpoTitle),
              SizedBox(height: 20, width: 892),
              Text(
                '\$${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                style: AppTextStyle.smallGreen,
              ),

              //TODO verificar se o produto ja
              //esta no carrinho para mostrar o botao
              SizedBox(height: 20, width: 892),
              Visibility(
                replacement: Container(
                  height: 80,
                  width: 300,
                  child: Row(
                    children: [
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          ProductCart? productCart = controller
                              .getProductCartByProduct(product);
                          if (productCart != null) {
                            if (productCart.quantity == 1) {
                              bool? deleteProduct = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("gato"),
                                    content: const Text(
                                      'A dialog is a type of modal window that\n'
                                      'appears in front of app content to\n'
                                      'provide critical information, or prompt\n'
                                      'for a decision to be made.',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(
                                            context,
                                          ).textTheme.labelLarge,
                                        ),
                                        child: const Text('Cancelar'),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(
                                            context,
                                          ).textTheme.labelLarge,
                                        ),
                                        child: const Text('Confirmar'),
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                              if (deleteProduct != null && deleteProduct) {
                                controller.removeProduct(product);
                              }

                              // controller.removeProduct(product);
                            } else {
                              controller.decrement(product);
                            }
                          }
                        },
                        child: Text("-", style: TextStyle(fontSize: 24)),
                      ),
                      SizedBox(width: 8),
                      // Text('teste'),
                      Text(
                        controller.existeProdutoPeloNome(product.name)
                            ? controller.carrinho
                                  .where((item) => item.name == product.name)
                                  .first
                                  .quantity
                                  .toString()
                            : '',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          controller.increment(product);
                        },
                        child: Text("+", style: TextStyle(fontSize: 24)),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                visible: !controller.existeProdutoPeloNome(product.name),
                child: AppButtonProducts(
                  onPressed: () {
                    controller.addProduct(product);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
