import 'package:fase5/main.dart' as app;
import 'package:fase5/presentation/pages/forgot_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("forgot password testing", () {
    testWidgets('enter email invalid', (WidgetTester tester) async {
      app.main();

      final errorMessageFinder =
          find.text('Por favor ingrese un correo electrónico válido');

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('loginTextForgotPassword')));
      await tester.pumpAndSettle();
      expect(find.byType(ForgotPasswordPage), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key('forgotPassInputEmail')), 'mor_2314');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('forgotPassButtonSend')));
      await tester.pumpAndSettle();

      expect(errorMessageFinder, findsOneWidget);
    });
    testWidgets('enter email valid', (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(const Key('loginTextForgotPassword')));
      await tester.pumpAndSettle();
      expect(find.byType(ForgotPasswordPage), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key('forgotPassInputEmail')), 'test@test.com');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('forgotPassButtonSend')));
      await tester.pumpAndSettle();
      final modalFinder = find.byType(AlertDialog);
      expect(modalFinder, findsOneWidget);
    });
  });
}
