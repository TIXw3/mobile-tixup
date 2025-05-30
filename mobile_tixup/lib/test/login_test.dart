import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_tixup/features/auth/presentation/pages/login_page.dart';

void main() {
  testWidgets('Teste de campos obrigatórios no login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    final loginButton = find.text('Entrar');
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text("Preencha todos os campos"), findsOneWidget);
  });

  testWidgets('Teste de login com credenciais válidas', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    await tester.enterText(find.byType(TextField).at(0), 'teste@email.com');
    await tester.enterText(find.byType(TextField).at(1), 'Senha789!');

    await tester.tap(find.text('Entrar'));
    await tester.pump();

    expect(find.text("Login realizado com sucesso"), findsOneWidget);
  });

  testWidgets('Teste de login com senha errada', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    await tester.enterText(
      find.byType(TextField).at(0),
      'emailinexistente@email.com',
    );
    await tester.enterText(find.byType(TextField).at(1), 'semSenha123*');

    await tester.tap(find.text('Entrar'));
    await tester.pump();

    expect(find.text("Credenciais inválidas"), findsOneWidget);
  });
}
