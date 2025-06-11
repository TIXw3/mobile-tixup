import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_tixup/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:mobile_tixup/viewmodels/forgot_password_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Teste de fluxo de esqueci a senha', (WidgetTester tester) async {
    final viewModel = ForgotPasswordViewModel();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<ForgotPasswordViewModel>.value(
          value: viewModel,
          child: const ForgotPasswordScreen(),
        ),
      ),
    );

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'teste@email.com');

    await tester.tap(find.text('Enviar'));
    await tester.pump();

    viewModel.isTokenSent = true;
    viewModel.notifyListeners();
    await tester.pump();

    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.text('Token de Recuperação'), findsOneWidget);
    expect(find.text('Nova Senha'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, 'Token de Recuperação'),
      '123456',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Nova Senha'),
      'novaSenhaSegura',
    );

    await tester.tap(find.text('Redefinir Senha'));
    await tester.pump();

    expect(find.byType(SnackBar), findsNothing);
  });
}
