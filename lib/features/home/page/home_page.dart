import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/controllers/home_controller.dart';
import 'package:flutter_application_1/features/home/page/widget/categories__state.dart';
import 'package:flutter_application_1/features/home/page/widget/products_section.dart';
import 'package:flutter_application_1/features/login/controllers/login_controller.dart';
import 'package:flutter_application_1/shared/app_text_style.dart';
import 'package:flutter_application_1/shared/widget/app_card_button.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeDilation) {
      context.read<HomeController>()
        ..getCategories()
        ..getproducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        leading: Consumer<LoginController>(
          builder: (context, loginController, child) {
            return Text(
              'Olá ${loginController.user!.nome}',
              style: AppTextStyle.title,
            );
          },
        ),
      ),
      body: Consumer<HomeController>(
        builder: (context, homeCrontroller, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Spacer(),
            //     Badge(
            //       label: Text('5'),
            //       child: IconButton(
            //         onPressed: () => print('sss'),
            //         icon: Icon(Icons.shopping_cart_outlined),
            //       ),
            //     ),
            //   ],
            // ),
            AppCardButton(),

            SizedBox(
              height: 157,
              child: PageView.builder(
                onPageChanged: (value) {
                  homeCrontroller.changePageViewIndex(value);
                },

                itemCount: homeCrontroller.images.length,
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                itemBuilder: (context, pagePosition) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: Image.asset(homeCrontroller.images[pagePosition]),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: homeCrontroller.indicators(
                  homeCrontroller.images.length,
                  homeCrontroller.pageViewIndex,
                ),
              ),
            ),
            CategoriesSection(
              state: homeCrontroller.categoriesState,
              categories: homeCrontroller.categories,
            ),

            ProductsSection(
              isLoading:
                  homeCrontroller.productsState == ProductsViewState.loading,
              hasError:
                  homeCrontroller.productsState == ProductsViewState.erros,
              products: homeCrontroller.products,
            ),

            // https://medium.com/@johnathanrocha/criando-um-carrossel-de-imagens-no-flutter-80156432c792
            ElevatedButton(
              onPressed: () {
                homeCrontroller
                  ..getCategories()
                  ..getproducts();
              },
              child: Text('asdasd'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
