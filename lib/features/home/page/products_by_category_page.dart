import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/controllers/products_by_category_controller.dart';
import 'package:flutter_application_1/features/home/models/products_model.dart';
import 'package:flutter_application_1/features/home/page/widget/products_card.dart';
import 'package:flutter_application_1/shared/app_text_style.dart';
import 'package:flutter_application_1/shared/widget/app_card_button.dart';
import 'package:flutter_application_1/shared/widget/app_text_field.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsByCategoryPage extends StatefulWidget {
  const ProductsByCategoryPage({super.key, required this.categoryName});

  static const String route = '/products-by-category';

  final String categoryName;

  @override
  State<ProductsByCategoryPage> createState() => _ProductsByCategoryPageState();
}

class _ProductsByCategoryPageState extends State<ProductsByCategoryPage> {
  static final List<Product> _fakeProducts = List.filled(
    6,
    Product(
      brand: 'Marca do produto',
      name: 'Nome do produto',
      imageUrl: '',
      price: 0,
      category: '',
      description: '',
    ),
  );

  String _selectedCountry = 'categoria';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsByCategoryController>()
        ..getProductsByCategory(widget.categoryName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.categoryName, style: AppTextStyle.title),
        // actions: [AppCardButton()],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ProductsByCategoryController>(
              builder: (context, controller, child) {
                if (controller.state == ProductsByCategoryViewState.error) {
                  return const Center(
                    child: Text('Problema ao resgatar produtos'),
                  );
                }
                AppCardButton();
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppTextField(
                    hintText: 'Buscar produtos',

                    onChanged: controller.search,
                  ),
                );
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Filtrar por marca',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      controller.selectBrand(value!);
                    },
                    items: [
                      DropdownMenuItem(value: 'Todos', child: Text('Todos')),
                      ...controller.brands.map((brand) {
                        return DropdownMenuItem(
                          value: brand,
                          child: Text(brand),
                        );
                      }),
                    ],
                  ),
                );

                final isLoading =
                    controller.state == ProductsByCategoryViewState.loading;
                final products = isLoading
                    ? _fakeProducts
                    : controller.products;

                if (!isLoading && products.isEmpty) {
                  return const Center(child: Text('Nenhum produto encontrado'));
                }

                return Skeletonizer(
                  enabled: isLoading,
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.62,
                        ),
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
