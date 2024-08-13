import 'package:fase5/main.dart' as app;
import 'package:fase5/presentation/pages/home_page.dart';
import 'package:fase5/presentation/pages/login_page.dart';
import 'package:fase5/presentation/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:store_design_system/store_design_system.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("cart Detail testing", () {
    testWidgets('cart add product card and buy', (WidgetTester tester) async {

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

      await tester.tap(find.byType(CardOrganism).first);
      await tester.pumpAndSettle();

      expect(find.byType(ProductDetailPage), findsOneWidget);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.shopping_cart));
      await tester.pumpAndSettle();
      expect(find.text('¡Agrega Productos al carrito!'), findsOneWidget);


      await tester.pageBack();
      await tester.pumpAndSettle();


      await tester.ensureVisible(find.byKey(const Key('productDetailAddCart')));
      await tester.tap(find.byKey(const Key('productDetailAddCart')));
      await tester.pumpAndSettle();
      
      await tester.tap(find.byIcon(Icons.shopping_cart));
      await tester.pumpAndSettle();

      expect(find.byType(CardCartOrganism), findsOneWidget);
    });
  });
}
