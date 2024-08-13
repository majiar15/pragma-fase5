import 'package:fase5/main.dart' as app;
import 'package:fase5/presentation/pages/home_page.dart';
import 'package:fase5/presentation/pages/login_page.dart';
import 'package:fase5/presentation/pages/support_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("support and contact testing", () {
    testWidgets('support page ', (WidgetTester tester) async {
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

      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('drawerContactPage')));
      await tester.pumpAndSettle();
      expect(find.byType(SupportContactPage), findsOneWidget);

      final errorMessageNameEmptyFinder =
          find.text('Por favor ingrese su nombre');
      final errorMessageEmailEmptyFinder =
          find.text('Por favor ingrese su correo electrónico');
      final errorMessageEmailInvalidFinder =
          find.text('Por favor ingrese un correo electrónico válido');

      final errorMessageSubjectEmptyFinder =
          find.text('Por favor ingrese un asunto');
      final errorMessageMessageEmptyFinder =
          find.text('Por favor ingrese un mensaje');

      await tester
          .ensureVisible(find.byKey(const Key('supportContactButtonSend')));
      await tester.tap(find.byKey(const Key('supportContactButtonSend')));
      await tester.pumpAndSettle();
      expect(errorMessageNameEmptyFinder, findsOneWidget);
      expect(errorMessageEmailEmptyFinder, findsOneWidget);
      expect(errorMessageSubjectEmptyFinder, findsOneWidget);
      expect(errorMessageMessageEmptyFinder, findsOneWidget);
await tester
          .ensureVisible(find.byKey(const Key('supportContactNameInput')));
      await tester.enterText(
          find.byKey(const Key('supportContactNameInput')), 'Martin');
      await tester.enterText(
          find.byKey(const Key('supportContactEmailInput')), 'email falso');
      await tester.enterText(
          find.byKey(const Key('supportContactSuBjectInput')),
          'agradecimiento');
      await tester.enterText(
          find.byKey(const Key('supportContactMessageInput')),
          'Mensaje de agradecimiento');

      await tester
          .ensureVisible(find.byKey(const Key('supportContactButtonSend')));
      await tester.tap(find.byKey(const Key('supportContactButtonSend')));
      await tester.pumpAndSettle();

      expect(errorMessageNameEmptyFinder, findsNothing);
      expect(errorMessageEmailEmptyFinder, findsNothing);
      expect(errorMessageEmailInvalidFinder, findsOneWidget);
      expect(errorMessageSubjectEmptyFinder, findsNothing);
      expect(errorMessageMessageEmptyFinder, findsNothing);

      await tester
          .ensureVisible(find.byKey(const Key('supportContactEmailInput')));

      await tester.enterText(
          find.byKey(const Key('supportContactEmailInput')), 'test@test.com');
            await tester
          .ensureVisible(find.byKey(const Key('supportContactButtonSend')));

          
      await tester.tap(find.byKey(const Key('supportContactButtonSend')));
      await tester.pumpAndSettle();


      expect(errorMessageEmailInvalidFinder, findsNothing);
    });
  });
}
