import 'package:fase5/presentation/pages/catalog_page.dart';
import 'package:fase5/presentation/pages/home_page.dart';
import 'package:fase5/presentation/pages/support_contact_page.dart';
import 'package:fase5/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:store_design_system/store_design_system.dart';


/// [AppLayout] es un widget de estado completo que define la estructura principal
/// de la aplicación, incluyendo un `AppBar`, un `Drawer` y un `IndexedStack` para
/// manejar la navegación entre diferentes páginas.
///
/// Este widget toma un nombre como parámetro, que se pasa a la página de inicio
/// para personalizar el saludo.
///
/// Las páginas se gestionan mediante un `IndexedStack`, lo que permite mantener
/// el estado de cada página cuando el usuario navega entre ellas.
class AppLayout extends StatefulWidget {
  final String name;

  const AppLayout({
    super.key,
    required this.name,
  });

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  /// Lista de páginas que se mostrarán en la aplicación.
  /// - La primera página es la página de inicio, que recibe el nombre del usuario.
  /// - La segunda página es la página de catálogo.
  /// - La tercera página es la página de contacto de soporte.
  late List<Widget> pages = [
    HomePage(name: widget.name),
    const CatalogPage(),
    const SupportContactPage(),
  ];

  void _navigatePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarMolecule(
        actions: [
          IconButton(
            onPressed: () => {Navigator.pushNamed(context, Routes.cart)},
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      drawer: DrawerOrganism(
        name: widget.name,
        items: [
          DrawerItemMolecule(
            key: const Key("drawerHomePage"),
            icon: Icons.home,
            label: 'Inicio',
            onTap: () {
              _navigatePage(0);
            },
          ),
          DrawerItemMolecule(
            key: const Key("drawerCatalogPage"),
            icon: Icons.search,
            label: 'Catálogo',
            onTap: () {
              _navigatePage(1);
            },
          ),
          DrawerItemMolecule(
            key: const Key("drawerContactPage"),
            icon: Icons.contact_mail,
            label: 'Contacto',
            onTap: () {
              _navigatePage(2);
            },
          ),
        ],
        onClose: () {
          Navigator.pushNamed(context, Routes.contact);
        },
        onTapLogout: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (Route<dynamic> route) => false,
          );
        },
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
    );
  }
}
