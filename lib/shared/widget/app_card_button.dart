import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/cart/controllers/cart_controller.dart';
import 'package:flutter_application_1/features/cart/page/cart_page.dart';
import 'package:provider/provider.dart';

class AppCardButton extends StatelessWidget {
  AppCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, controller, child) {
        return Row(
          verticalDirection: VerticalDirection.down,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Spacer(),
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () => Navigator.pushNamed(context, CartPage.route),
                  icon: Icon(Icons.shopping_cart_outlined),
                ),
                Visibility(
                  visible: controller.itemcarrinho > 0,
                  child: Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      padding: EdgeInsets.all(0.3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      constraints: BoxConstraints(minWidth: 16, maxWidth: 16),
                      child: Text(
                        '${controller.itemcarrinho}',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
