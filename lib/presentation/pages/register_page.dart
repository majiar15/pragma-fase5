import 'package:fase5/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:store_design_system/templates/create_account_template.dart';


/// [RegisterPage] es una página para registrar una nueva cuenta de usuario.
/// Permite al usuario ingresar su nombre, contraseña y confirmar la contraseña.
/// Proporciona funcionalidades para crear una cuenta y navegar a la página de inicio.
///
/// Utiliza el [CreateAccountTemplate] para construir la interfaz de usuario de registro.
class RegisterPage extends StatelessWidget {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateAccountTemplate(
      confirmPasswordController: confirmPasswordController,
      onTapCreateAccount: () {
        Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.layout,
            (route) => false,
            arguments: {
              'name': userController.text
            }
          );
      },
      onTapLoginLink: () { Navigator.pop(context); },
      passwordController: passwordController,
      userController: userController,
    );
  }
}