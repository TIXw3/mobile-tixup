import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_tixup/features/auth/presentation/pages/register_page.dart';

void main() {
  testWidgets('Teste de campos obrigatórios no registro', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: TelaRegistro()));

    final criarButton = find.text('Criar');
    expect(criarButton, findsOneWidget);
    await tester.tap(criarButton);
    await tester.pump();

    expect(find.text("Preencha todos os campos"), findsOneWidget);
  });

  testWidgets('Teste de senhas diferentes', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TelaRegistro()));

    await tester.enterText(find.byType(TextField).at(0), 'Usuário Teste');
    await tester.enterText(find.byType(TextField).at(1), 'teste@email.com');
    await tester.enterText(find.byType(TextField).at(2), 'senha123');
    await tester.enterText(
      find.byType(TextField).at(3),
      'senha456',
    ); // Senha diferente
    await tester.enterText(find.byType(TextField).at(4), '01/01/2000');
    await tester.enterText(find.byType(TextField).at(5), '123.456.789-09');
    await tester.enterText(find.byType(TextField).at(6), '(11) 99999-9999');

    await tester.tap(find.text('Criar'));
    await tester.pump();

    expect(find.text("As senhas não coincidem"), findsOneWidget);
  });
}
