import 'dart:async';

import 'package:fase5/main.dart';
import 'package:fase5/presentation/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_models_commons/flutter_models_commons.dart'
    show CartUIModel, ProductCartUIModel;
import 'package:store_design_system/store_design_system.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
            onTapBuyNow: () => {
              if (snapshot.data!.isEmpty)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: StoreColorsFoundation.primaryColor,
                        behavior: SnackBarBehavior
                            .floating,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                            margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 80),
                        content: const Text(
                          'No tiene productos agregados al carrito',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: StoreTypographyFoundation.fontSizeH5,
                            fontWeight: StoreTypographyFoundation.fontWeightBold
                          ),
                        )),
                  )
                }
              else
                {
                  DialogAtom(
                      title: "Muy bien!",
                      content: "se ha tomado su pedido exitosamente",
                      rightButtonText: "Cerrar",
                      onRightButtonPressed: () {
                        cartBloc.cleanCart();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }).show(context)
                }
            },
          );
        });
  }
}
