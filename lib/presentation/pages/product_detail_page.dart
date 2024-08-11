import 'package:fase5/main.dart';
import 'package:fase5/presentation/bloc/cart_bloc.dart';
import 'package:fase5/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart'
    show DiscountedProduct, ProductCartUIModel;
import 'package:store_design_system/store_design_system.dart';

/// [ProductDetailPage] es una página que muestra los detalles de un producto y una lista de productos similares.
/// Permite al usuario agregar el producto al carrito y ver detalles de productos similares.
///
/// La página utiliza [CartBloc] para gestionar el estado del carrito y proporciona funciones para
/// añadir productos al carrito y navegar a las páginas de detalles de productos similares.
class ProductDetailPage extends StatelessWidget {
  final DiscountedProduct product;
  final List<DiscountedProduct> productsSimilar;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.productsSimilar,

  });

  @override
  Widget build(BuildContext context) {
    final CartBloc cartBloc = Injector.of(context).cartBloc;
    return ProductDetailTemplate(
      appBar: AppBarMolecule(
        actions: [
          IconButton(
            onPressed: () => {Navigator.pushNamed(context, Routes.cart)},
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      onTapAddCart: (product) {
        cartBloc.addItem(ProductCartUIModel(
            productId: product.id!,
            title: product.title,
            price: product.price,
            image: product.image,
            quantity: 1),
          );
          final snackBar = SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 10),
                Expanded(child: Text('Producto agregado al carrito correctamente')),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Ver carrito',
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, Routes.cart);
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

      },
      product: product,
      productList: productsSimilar,
      onTapSimilarProduct: (productSimilar){
        Navigator.pushNamed(
          context,
          Routes.productDetail,
          arguments: {
            'product': productSimilar,
            'productsSimilar': productsSimilar,
          },
        );
      }
    );
  }
}
