import 'dart:async';

import 'package:fase5/presentation/bloc/home_bloc.dart';
import 'package:fase5/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:fase5/main.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart';
import 'package:store_design_system/store_design_system.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  StreamSubscription? _subscriptionProduct;
  StreamSubscription? _subscriptionCategories;

  List<ProductModel> productList = [];
  List<String> categoryList = [];

  _init() async {
    final HomeBloc homeBloc = Injector.of(context).homeBloc;
    homeBloc.getAllProducts();
    homeBloc.getAllCategories();

    _subscriptionProduct = homeBloc.productsStream.listen(
      (products) {
        setState(() {
          productList = products;
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
    _subscriptionProduct!.cancel();
    _subscriptionCategories!.cancel();

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
        appBar: AppBarBarMolecule(
          actions: [
            IconButton(
                onPressed: onTapCart, icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            productList.isNotEmpty
                ? HomeTemplate(
                    onTapLogin: () => {print("login")},
                    onTapSignUp: () => {print("sigup")},
                    onChangePasswordText: (text) => {print("change passs")},
                    onChangeUserText: (text) => {print("change user")},
                    onTapCategory: (String) {},
                    productList: productList,
                    onTapTrendingProducts: () {},
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
                          'onTapProductSimilar': (ProductModel product) {},
                          'onTapAddCart': (ProductModel product) {},
                        },
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
            productList.isNotEmpty
                ? CatalogTemplate(
                    productList: productList,
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

  void onTapCart() {}
}
