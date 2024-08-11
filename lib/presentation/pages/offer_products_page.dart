import 'package:fase5/main.dart';
import 'package:fase5/presentation/bloc/cart_bloc.dart';
import 'package:fase5/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart' show DiscountedProduct, ProductCartUIModel;
import 'package:store_design_system/store_design_system.dart';

/// [OfferProductsPage] es una página que muestra productos en oferta y productos similares.
/// Permite al usuario agregar productos al carrito y navegar a la página de detalles del producto.
///
/// La página utiliza [CartBloc] para gestionar el estado del carrito y proporciona funciones de
/// navegación y de interacción con los productos.
class OfferProductsPage extends StatelessWidget {
  final List<DiscountedProduct> products;
  final List<DiscountedProduct> productsSimilar;
  final Function(DiscountedProduct) onTapAddCart;
  const OfferProductsPage({
    super.key,
    required this.products,
    required this.productsSimilar,
    required this.onTapAddCart,
  });

  @override
  Widget build(BuildContext context) {
    final CartBloc cartBloc = Injector.of(context).cartBloc;

    return OfferTemplate(
      onTapAddCart: (product) {
        cartBloc.addItem(
          ProductCartUIModel(
            productId: product.id!,
            title: product.title,
            price: product.price,
            image: product.image,
            quantity: 1
          )
        );
      },
      productsSimilar: productsSimilar,
      productList: products,
      onTapCard: (product){
          Navigator.pushNamed(
            context,
            Routes.productDetail,
            arguments: {
              'product': product,
              'productsSimilar': productsSimilar,
            },
          );
      },
    );
  }
}
