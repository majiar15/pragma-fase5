import 'dart:async';
import 'dart:math';

import 'package:fase5/presentation/bloc/home_bloc.dart';
import 'package:fase5/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:fase5/main.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';
import 'package:store_design_system/templates.dart';

class HomePage extends StatefulWidget {
  final String name;
  const HomePage({super.key, required this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}
/// [HomePage] es una página que muestra una lista de productos con descuentos
/// y permite a los usuarios interactuar con ellos. Muestra productos destacados
/// y proporciona navegación a detalles del producto y ofertas.
///
/// La clase maneja la suscripción a flujos de datos y el procesamiento de productos
/// para agregar descuentos aleatorios.
class _HomePageState extends State<HomePage> {
  late StreamSubscription _subscriptionProduct;

  List<DiscountedProduct> productList = [];
  List<DiscountedProduct> productsDiscountList = [];

  List<DiscountedProduct> addDiscount(List<ProductModel> products) {
    List<DiscountedProduct> productDiscounted = [];
    List<int> selectIndex = [];
    Random random = Random();
    for (int i = 0; i < 10; i++) {
      int randomIndex = random.nextInt(products.length - 1);
      if (!selectIndex.contains(randomIndex)) {
        selectIndex.add(randomIndex);
      }
    }

    for (var i = 0; i < products.length; i++) {
      if (selectIndex.contains(i)) {
        int randomDiscount = random.nextInt(60);
        productDiscounted.add(
            DiscountedProduct.fromProductModel(products[i], randomDiscount));
        productsDiscountList.add(
            DiscountedProduct.fromProductModel(products[i], randomDiscount));
        continue;
      }
      productDiscounted.add(DiscountedProduct.fromProductModel(products[i], 0));
    }
    return productDiscounted;
  }

  _init() async {
    HomeBloc homeBloc = Injector.of(context).homeBloc;
    homeBloc.getAllProducts();

    _subscriptionProduct = homeBloc.productsStream.listen(
      (products) async {
        final productsDiscounted = addDiscount(products);
        setState(() {
          homeBloc.setProductDiscount(productsDiscounted);
          productList = productsDiscounted;
        });
      },
      onError: (error) {},
    );
  }

  @override
  void dispose() {
    _subscriptionProduct.cancel();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return productList.isNotEmpty
        ? HomeTemplate(
            name: widget.name,
            productList: productList,
            onTapTrendingProducts: () {
              Navigator.pushNamed(
                context,
                Routes.offer,
                arguments: {
                  'products': productsDiscountList,
                  'productsSimilar': productList,
                  'onTapProductSimilar': (ProductModel product) {},
                  'onTapAddCart': (ProductModel product) {},
                },
              );
            },
            onTapCard: (product) {
              final productSimilar = productList
                  .where((element) => element.category == product.category)
                  .toList();
              Navigator.pushNamed(
                context,
                Routes.productDetail,
                arguments: {
                  'product': product,
                  'productsSimilar': productSimilar,
                },
              );
            },
          )
        : const Center(child: CircularProgressIndicator());
  }
}
