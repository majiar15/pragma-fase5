import 'package:fase5/main.dart';
import 'package:fase5/presentation/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart'
    show CartUIModel, ProductCartUIModel;
import 'package:store_design_system/store_design_system.dart';
/// [CartPage] es una página de estado completo que muestra los productos
/// agregados al carrito de compras y permite al usuario proceder a la compra.
/// Utiliza el patrón BLoC (Business Logic Component) para manejar la lógica del carrito.
///
/// La página interactúa con un `CartBloc` para cargar los productos en el carrito
/// y escuchar cambios en el estado del carrito a través de un `StreamBuilder`.
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CartBloc cartBloc = Injector.of(context).cartBloc;
      cartBloc.loadCart();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CartBloc cartBloc = Injector.of(context).cartBloc;

    return StreamBuilder<List<ProductCartUIModel>>(
      stream: cartBloc.stream,
      initialData: const [],
      builder: (context, snapshot) {
        return CartTemplate(
          cart: CartUIModel(products: snapshot.data!),

          onTapBuyNow: () {
            if (snapshot.data!.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: StoreColorsFoundation.primaryColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  content: const Text(
                    'No tiene productos agregados al carrito',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: StoreTypographyFoundation.fontSizeH5,
                      fontWeight: StoreTypographyFoundation.fontWeightBold,
                    ),
                  ),
                ),
              );
            } else {
              DialogAtom(
                title: "¡Muy bien!",
                content: "Se ha tomado su pedido exitosamente",
                rightButtonText: "Cerrar",
                onRightButtonPressed: () {
                  cartBloc.cleanCart();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ).show(context);
            }
          },
        );
      },
    );
  }
}
