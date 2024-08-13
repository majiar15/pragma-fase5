import 'package:fase5/main.dart' as app;
import 'package:fase5/presentation/pages/home_page.dart';
import 'package:fase5/presentation/pages/login_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/src/foundation/key.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("login testing", () {
    testWidgets('Login failed', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byType(LoginPage), findsOneWidget);

    await tester.enterText(find.byKey(const Key('loginUsernameField')), 'userTest');
    await tester.enterText(find.byKey(const Key('loginPasswordField')), 'paass fail');

    await tester.tap(find.byKey(const Key('loginOnTapLogin')));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsNothing);

  });
    testWidgets('Login success', (WidgetTester tester) async {
    app.main();

      await tester.pumpAndSettle(const Duration(seconds:3));

      expect(find.byType(LoginPage), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key('loginUsernameField')), 'mor_2314');
      await tester.enterText(
          find.byKey(const Key('loginPasswordField')), '83r5^_');
      await tester.pumpAndSettle(const Duration(seconds: 4));

      await tester.tap(find.byKey(const Key('loginOnTapLogin')));
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
