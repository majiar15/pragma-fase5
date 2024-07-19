import 'dart:async';
import 'dart:math';

import 'package:fase5/presentation/bloc/home_bloc.dart';
import 'package:fase5/presentation/pages/support_contact_page.dart';
import 'package:fase5/presentation/routes/routes.dart';
import 'package:fase5/presentation/pages/catalog_page.dart';
import 'package:flutter/material.dart';
import 'package:fase5/main.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';
import 'package:store_design_system/atoms.dart';
import 'package:store_design_system/molecules.dart';
import 'package:store_design_system/templates.dart';

class HomePage extends StatefulWidget {
  final String name;
  const HomePage({super.key, required this.name});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late StreamSubscription _subscriptionProduct;
  late StreamSubscription _subscriptionCategories;

  List<DiscountedProduct> productList = [];
  List<DiscountedProduct> productsDiscountList = [];
  List<String> categoryList = [];

  List<DiscountedProduct> addDiscount(List<ProductModel> products) {
    List<DiscountedProduct> productDiscounted = [];
    List<int> selectIndex = [];
    Random random = Random();
    for (int i = 0; i < 10; i++) {
      int randomIndex = random.nextInt(products.length - 1);
      if(!selectIndex.contains(randomIndex)){
        selectIndex.add(randomIndex);
      }
    }

    for (var i = 0; i < products.length; i++) {
      if (selectIndex.contains(i)) {
        int randomDiscount = random.nextInt(60);
        productDiscounted.add(
          DiscountedProduct.fromProductModel(products[i], randomDiscount)
        );
        productsDiscountList.add(
          DiscountedProduct.fromProductModel(products[i], randomDiscount)
        );
        continue;
      }
      productDiscounted.add(
        DiscountedProduct.fromProductModel(products[i], 0)
      );
    }
    return productDiscounted;
  }

  _init() async {
    final HomeBloc homeBloc = Injector.of(context).homeBloc;
    homeBloc.getAllProducts();
    homeBloc.getAllCategories();

    _subscriptionProduct = homeBloc.productsStream.listen(
      (products) {
        final productsDiscounted = addDiscount(products);
        setState(() {
          productList = productsDiscounted;
        });
      },
      onError: (error) {},
    );

    _subscriptionCategories = homeBloc.categoryStream.listen(
      (categories) {
        setState(() {
          categoryList = categories;
        });
      },
      onError: (error) {},
    );
  }

  @override
  void dispose() {
    _subscriptionProduct.cancel();
    _subscriptionCategories.cancel();

    final HomeBloc homeBloc = Injector.of(context).homeBloc;
    homeBloc.dispose();
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
    const List<Widget> _widgetOptions = <Widget>[
      Text('Home Page',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
      Text('Search Page',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
      Text('Contact Page',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    ];
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBarMolecule(
          actions: [
            IconButton(
              onPressed: () => {Navigator.pushNamed(context, Routes.cart)},
              icon: const Icon(Icons.shopping_cart),
            )
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            productList.isNotEmpty
                ? HomeTemplate(
                    name: widget.name,
                    productList: productList,
                    onTapTrendingProducts: () {
                      Navigator.pushNamed(
                        context,
                        Routes.offer,
                        arguments: {
                          'products': productsDiscountList,
                          'productsSimilar':productList,
                          'onTapProductSimilar': (ProductModel product) {},
                          'onTapAddCart': (ProductModel product) {},
                        },
                      );
                    },
                    onTapCard: (product) {
                      final productSimilar = productList
                          .where(
                              (element) => element.category == product.category)
                          .toList();
                      Navigator.pushNamed(
                        context,
                        Routes.productDetail,
                        arguments: {
                          'product': product,
                          'productsSimilar': productSimilar,
                          'discountPercentage': product?.discountPercentage ?? 0,
                          'onTapProductSimilar': (ProductModel product) {},
                          'onTapAddCart': (ProductModel product) {},
                        },
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
            productList.isNotEmpty
                ? CatalogPage(
                    productsSimilar: productList,
                    categories: categoryList,
                    onTapAddCart: (ProductModel) {},
                    onTapProductSimilar: (product) {
                      final productSimilar = productList
                          .where(
                              (element) => element.category == product.category)
                          .toList();
                      Navigator.pushNamed(
                        context,
                        Routes.productDetail,
                        arguments: {
                          'product': product,
                          'productsSimilar': productSimilar,
                          'onTapProductSimilar': (ProductModel product) {},
                          'onTapAddCart': (ProductModel product) {},
                        },
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
            const SupportContactPage()
          ],
        ),
        bottomNavigationBar: BottomNavigationBarMolecule(
          items: const [
            NavigationItemAtom(
              icon: Icons.home,
              label: 'Inicio',
            ),
            NavigationItemAtom(
              icon: Icons.search,
              label: 'Catalogo',
            ),
            NavigationItemAtom(
              icon: Icons.contact_mail,
              label: 'Contacto',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
