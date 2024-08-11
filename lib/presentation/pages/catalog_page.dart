import 'dart:async';

import 'package:fase5/main.dart';
import 'package:fase5/presentation/bloc/home_bloc.dart';
import 'package:fase5/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart'
    show DiscountedProduct;
import 'package:store_design_system/templates/catalog_template.dart';
/// [CatalogPage] es una página de estado completo que muestra una lista de productos
/// con descuentos y permite al usuario buscar, filtrar y ordenar los productos.
/// Utiliza el patrón BLoC (Business Logic Component) para manejar la lógica de negocio
/// relacionada con los productos y categorías.
///
/// La página se actualiza en función de los eventos de flujo de datos recibidos de
/// `HomeBloc`, y muestra una interfaz personalizada utilizando el widget `CatalogTemplate`.
class CatalogPage extends StatefulWidget {
  const CatalogPage({
    super.key,
  });

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late List<DiscountedProduct> _filteredList = [];

  late StreamSubscription _subscriptionProduct;

  late StreamSubscription _subscriptionCategories;

  List<DiscountedProduct> productList = [];

  List<DiscountedProduct> productsDiscountList = [];

  List<String> categoryList = [];

  _init() async {
    final HomeBloc homeBloc = Injector.of(context).homeBloc;
    await Future.delayed(const Duration(seconds: 1));
    homeBloc.getProductDiscount();
    homeBloc.getAllCategories();

    _subscriptionProduct = homeBloc.productsDiscountsStream.listen(
      (products) {
        setState(() {
          _filteredList = List.from(products);
          productList = List.from(products);
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

    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
    super.initState();
  }

  /// Ordena la lista de productos filtrados en función de la opción de orden seleccionada.
  ///
  /// [sortOption] es una cadena que especifica el criterio de ordenación, como "title_asc" 
  /// para ordenar por título en orden ascendente o "price_desc" para ordenar por precio en 
  /// orden descendente.
  void _sortProducts(String sortOption) {
    switch (sortOption) {
      case "title_asc":
        setState(() {
          _filteredList.sort((a, b) => a.title.compareTo(b.title));
        });
        break;
      case "title_desc":
        setState(() {
          _filteredList.sort((a, b) => b.title.compareTo(a.title));
        });
        break;
      case "price_asc":
        setState(() {
          _filteredList.sort((a, b) => a.price.compareTo(b.price));
        });
        break;
      case "price_desc":
        setState(() {
          _filteredList.sort((a, b) => b.price.compareTo(a.price));
        });
        break;
      case "reviews_asc":
        setState(() {
          _filteredList.sort((a, b) => a.rating.rate.compareTo(b.rating.rate));
        });
        break;
      case "reviews_desc":
        setState(() {
          _filteredList.sort((a, b) => b.rating.rate.compareTo(a.rating.rate));
        });
        break;
    }
  }

  /// Realiza una búsqueda en la lista de productos en función de la consulta proporcionada.
  ///
  /// [query] es una cadena que representa el término de búsqueda. Filtra la lista de productos
  /// para incluir solo aquellos cuyo título o descripción contiene el término de búsqueda.
  void _performSearch(String query) {
    setState(() {
      _filteredList = productList
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  /// Filtra los productos en la lista en función de la opción de filtro seleccionada.
  ///
  /// [filterOption] es una cadena que representa la categoría para filtrar los productos.
  /// Si la categoría está en la lista de categorías, se filtra la lista de productos.
  /// De lo contrario, se restablece la lista de productos a su estado original.
  void _filterProducts(String filterOption) {
    if (categoryList.contains(filterOption)) {
      setState(() {
        _filteredList = productList
            .where((product) => product.category == filterOption)
            .toList();
      });
    } else {
      setState(() {
        _filteredList = List.from(productList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CatalogTemplate(
      onTapCard: (product) {
        final productSimilar = productList
          .where(
              (element) => element.category == product.category)
          .toList();
        Navigator.pushNamed(
          context,
          Routes.productDetail,
          arguments: {
            "product": product,
            "productsSimilar": productSimilar,
          }
        );
      },
      productList: _filteredList,
      categories: categoryList,
      onSearch: _performSearch,
      onFilterProducts: _filterProducts,
      onSortSelected: _sortProducts,
    );
  }
}
