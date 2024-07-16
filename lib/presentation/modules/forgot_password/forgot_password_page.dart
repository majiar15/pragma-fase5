import 'package:flutter/material.dart';
import 'package:store_desing_system/atoms/dialog_atom.dart';
import 'package:store_desing_system/templates/forgot_password_template.dart';

class ForgotPasswordPage extends StatelessWidget {
  final emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordTemplate(
        emailController: emailController,
        onSubmit: () {
          DialogAtom(
                  title: "Recuperar contraseña",
                  content: "se ha enviado un correo a su email, por favor siga los pasos",
                  rightButtonText: "cerrar",
                  onRightButtonPressed: () => {
                    Navigator.pop(context),
                    Navigator.pop(context)
                    }
                  )
              .show(context);
        });
  }
}
