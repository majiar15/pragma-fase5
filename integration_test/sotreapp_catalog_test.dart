import 'package:fase5/main.dart' as app;
import 'package:fase5/presentation/pages/catalog_page.dart';
import 'package:fase5/presentation/pages/home_page.dart';
import 'package:fase5/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:store_design_system/store_design_system.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("catalog testing", () {
    testWidgets('catalog search, filter and sort',
        (WidgetTester tester) async {
      // login
      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byType(LoginPage), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key('loginUsernameField')), 'mor_2314');
      await tester.enterText(
          find.byKey(const Key('loginPasswordField')), '83r5^_');

      await tester.tap(find.byKey(const Key('loginOnTapLogin')));
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);

      // home test
      await tester.pumpAndSettle( const Duration(seconds: 3));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('drawerCatalogPage')));
      await tester.pumpAndSettle();
      expect(find.byType(CatalogPage), findsOneWidget);
    
      // search test
      // expect(find.text("20 Productos"), findsOneWidget);

      await tester.ensureVisible(find.byKey(const Key('catalogSearchInput')));
      await tester.enterText(
        find.byKey(const Key('catalogSearchInput')), 'men');
      await tester.pumpAndSettle();

      // expect(find.text("12 Productos"), findsOneWidget);

      await tester.ensureVisible(find.byKey(const Key('catalogSearchInput')));
      await tester.enterText(
        find.byKey(const Key('catalogSearchInput')), '');
      await tester.pumpAndSettle();

      // expect(find.text("20 Productos"), findsOneWidget);

      // filter test
      await tester.tap(find.byType(FilterMenuMolecule));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('filterItem jewelery')) );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FilterMenuMolecule));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('filterItem All')));
      await tester.pumpAndSettle();


      

      // // sort test
      await tester.tap(find.byType(SortMenuMolecule));
      await tester.pumpAndSettle();
      
      
      await tester.tap(find.byKey(const Key('sort Item price_asc')));
      await tester.pumpAndSettle();
    });
  
  });
}
