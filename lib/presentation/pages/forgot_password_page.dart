import 'package:fase5/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:store_design_system/atoms/dialog_atom.dart';
import 'package:store_design_system/templates/forgot_password_template.dart';

/// [ForgotPasswordPage] es una página de estado que permite al usuario
/// solicitar la recuperación de su contraseña. Esta página proporciona un campo
/// de entrada para el correo electrónico y un botón para enviar la solicitud.
///
/// La página muestra un diálogo informativo una vez que se envía la solicitud de recuperación.
/// no se realiza el envió de correo, solo se simula
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
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.login,
                        (Route<dynamic> route) => false,
                      )
                    }
                  )
              .show(context);
        });
  }
}
