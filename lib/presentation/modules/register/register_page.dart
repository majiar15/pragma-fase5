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
      onTapCreateAccount: () {  },
      onTapLoginLink: () { Navigator.pop(context); },
      passwordController: passwordController,
      userController: userController,
    );
  }
}