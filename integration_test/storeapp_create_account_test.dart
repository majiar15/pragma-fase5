import 'package:fase5/main.dart' as app;
import 'package:fase5/presentation/pages/home_page.dart';
import 'package:fase5/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("create account testing", () {
    testWidgets('enter invalid data and enter valid data', (WidgetTester tester) async {
      app.main();

      final errorMessageUserEmptyFinder =
          find.text('Por favor ingrese su nombre de usuario');
      final errorMessagePasswordEmptyFinder =
          find.text('Por favor ingrese una contraseña');
      final errorMessagePasswordShortFinder =
          find.text('La contraseña debe tener al menos 6 caracteres');

      final errorMessagePasswordConfirmFinder =
          find.text('Por favor confirme su contraseña');
      final errorMessagePasswordConfirmMatcherFinder =
          find.text('Las contraseñas no coinciden');

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('loginTextRegister')));
      await tester.pumpAndSettle();
      expect(find.byType(RegisterPage), findsOneWidget);


      await tester.tap(find.byKey(const Key('createAccountRegisterButton')));
      await tester.pumpAndSettle();

      expect(errorMessageUserEmptyFinder, findsOneWidget);
      expect(errorMessagePasswordEmptyFinder, findsOneWidget);
      expect(errorMessagePasswordConfirmFinder, findsOneWidget);


      await tester.enterText(
          find.byKey(const Key('createAccountUsernameField')), 'mor_2314');
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key('createAccountPasswordField')), '123');
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key('createAccountConfirmPasswordField')), '123456');
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(const Key('createAccountRegisterButton')));
      await tester.tap(find.byKey(const Key('createAccountRegisterButton')));
      await tester.pumpAndSettle();

      expect(errorMessagePasswordShortFinder, findsOneWidget);
      expect(errorMessagePasswordConfirmMatcherFinder, findsOneWidget);


      await tester.enterText(
          find.byKey(const Key('createAccountPasswordField')), '123456789');
      await tester.pumpAndSettle();

      await tester.enterText(
          find.byKey(const Key('createAccountConfirmPasswordField')), '123456789');
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(const Key('createAccountRegisterButton')));
      await tester.tap(find.byKey(const Key('createAccountRegisterButton')));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
