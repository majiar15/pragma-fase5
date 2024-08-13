import 'package:fase5/main.dart' as app;
import 'package:fase5/presentation/pages/home_page.dart';
import 'package:fase5/presentation/pages/login_page.dart';
import 'package:fase5/presentation/pages/offer_products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:store_design_system/store_design_system.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("ofert product testing", () {
    testWidgets('offert product ', (WidgetTester tester) async {

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
      await tester.ensureVisible(find.byType(BannerTrendingProductsMolecule));
      await tester.tap(find.byKey(const Key('homeBannerOffer')));
      await tester.pumpAndSettle();

      expect(find.byType(OfferProductsPage), findsOneWidget);
      expect(find.byType(CardOrganism), findsAny);

    });
  });
}
