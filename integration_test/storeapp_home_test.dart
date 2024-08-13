import 'package:fase5/main.dart' as app;
import 'package:fase5/presentation/pages/catalog_page.dart';
import 'package:fase5/presentation/pages/home_page.dart';
import 'package:fase5/presentation/pages/login_page.dart';
import 'package:fase5/presentation/pages/support_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:store_design_system/store_design_system.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("home testing", () {
    testWidgets('home page - validate render cards',
        (WidgetTester tester) async {
      // home login

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

      final hour = DateTime.now().hour;
      final messageGreeting = hour < 12
          ? 'Buenos días'
          : hour < 18
              ? 'Buenas tardes'
              : 'Buenas noches';

      expect(find.text('$messageGreeting, mor_2314'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.byType(CardOrganism), findsNWidgets(8));
      expect(find.byType(CardSmallOrganism), findsNWidgets(2));
    });

    testWidgets('home app drawer navigation success',
        (WidgetTester tester) async {
      // home login
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

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('drawerCatalogPage')));
      await tester.pumpAndSettle();
      expect(find.byType(CatalogPage), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('drawerContactPage')));
      await tester.pumpAndSettle();
      expect(find.byType(SupportContactPage), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('drawerLogout')));
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    });
  
  });
}
