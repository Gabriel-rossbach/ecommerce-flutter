import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/controllers/home_controller.dart';
import 'package:flutter_application_1/features/home/models/products_model.dart';
import 'package:flutter_application_1/shared/app_colors.dart';
import 'package:flutter_application_1/shared/app_text_style.dart';
import 'package:flutter_application_1/shared/widget/app_button_products.dart';
import 'package:flutter_application_1/shared/widget/app_elevated_button.dart';

import 'package:skeletonizer/skeletonizer.dart';

class ProductCard extends StatelessWidget {
  ProductCard({super.key, required this.product});

  final Product product;

  final HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print('clicou no produto ${product.name}');
        var result = await showModalBottomSheet(
          context: context,
          showDragHandle: true,
          isScrollControlled: true,
          builder: (context) {
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
                  SizedBox(height: 40, width: 700),
                  Text(product.brand, style: AppTextStyle.smallGrey),
                  SizedBox(height: 40, width: 700),
                  Text(product.description, style: AppTextStyle.corpoTitle),
                  SizedBox(height: 40, width: 700),
                  Text(
                    '\$${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: AppTextStyle.smallGreen,
                  ),
                  AppButtonProducts(onPressed: controller.increment),
                ],
              ),
            );
          },
        );
        print(result);
        if (result != null) {
          print('Produto selecionado: $result');
          HomeController().carrinho.add(result);
          print('Carrinho atualizado: ${HomeController().carrinho}');
        } else {
          print('Nenhum produto foi selecionado');
        }
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
  }
}
