import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/controllers/home_controller.dart';

class AppCardButton extends StatelessWidget {
  AppCardButton({super.key});
  final HomeController intemcarrinho = HomeController();

  @override
  Widget build(BuildContext context) {
    return Row(
      verticalDirection: VerticalDirection.down,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Spacer(),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () => print('aaz'),
              icon: Icon(Icons.shopping_cart_outlined),
            ),
            Positioned(
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
                  '${intemcarrinho.intemcarrinho}',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
