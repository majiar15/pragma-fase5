import 'dart:async';

import 'package:fase5/main.dart';
import 'package:fase5/presentation/bloc/auth_bloc.dart';

import 'package:flutter/material.dart';
import 'package:store_design_system/templates/login_template.dart';
import 'package:store_design_system/foundation/colors_foundation.dart';
import 'package:store_design_system/atoms/dialog_atom.dart';

import 'package:fase5/presentation/routes/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  TextEditingController userController =
      TextEditingController(text: "mor_2314");
  TextEditingController passwordController =
      TextEditingController(text: "83r5^_");
  StreamSubscription<String>? _subscription;
  _init() async {
    final AuthBloc authBloc = Injector.of(context).authBloc;
    _subscription = authBloc.stream.listen(
      (token) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (route) => false);
      },
      onError: (error) {
        setState(() {
          isLoading = false;
        });
        DialogAtom(
            title: "Acceso denegado",
            content: "Usuario o contraseña incorrecta",
            rightButtonText: "Cerrar",
            onRightButtonPressed: () => {Navigator.pop(context)}).show(context);
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
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
    final authBloc = Injector.of(context).authBloc;

    return LoginTemplate(
      userController: userController,
      passwordController: passwordController,
      onTapForgotPassword: () =>
          {Navigator.pushNamed(context, Routes.forgotPassword)},
      onTapLogin: () => {
        setState(() {
          isLoading = true;
        }),
        authBloc.login(userController.value.text, passwordController.value.text)
      },
      onTapSignUp: () => {
        Navigator.pushNamed(context, Routes.register),
      },
      isLoadingButtonLogin: isLoading,
    );
  }
}
