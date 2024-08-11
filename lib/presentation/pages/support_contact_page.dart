import 'package:flutter/material.dart';
import 'package:store_design_system/store_design_system.dart';
/// [SupportContactPage] es una página que proporciona un formulario de contacto para soporte.
/// Utiliza el [SupportContactTemplate] para construir la interfaz de usuario de la página de contacto.
class SupportContactPage extends StatelessWidget {
  const SupportContactPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SupportContactTemplate();
  }
}
