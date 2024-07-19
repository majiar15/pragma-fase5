import 'package:fase5/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:store_design_system/templates/create_account_template.dart';


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
            Routes.home,
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