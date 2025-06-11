import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_tixup/features/events/InformationPurchase_page.dart';

void main() {
  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: InformationPurchasePage()));
  }

  testWidgets('Renderiza campos do formulário e botão', (tester) async {
    await pumpPage(tester);

    expect(find.byType(TextFormField), findsNWidgets(4));
    expect(find.text('Nome completo'), findsOneWidget);
    expect(find.text('CPF'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('Telefone'), findsOneWidget);
    expect(find.text('Confirmar Compra'), findsOneWidget);
  });

  testWidgets('Validação de formulário exige campos preenchidos', (
    tester,
  ) async {
    await pumpPage(tester);

    await tester.tap(find.text('Confirmar Compra'));
    await tester.pump();

    expect(find.text('Informe seu nome'), findsOneWidget);
    expect(find.text('Informe seu CPF'), findsOneWidget);
    expect(find.text('Informe seu e-mail'), findsOneWidget);
    expect(find.text('Informe seu telefone'), findsOneWidget);
  });

  testWidgets('Resumo da compra aparece com dados no SharedPreferences', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      'purchase_eventoData': jsonEncode({
        'id': '1',
        'nome': 'Festa Teste',
        'data': '2025-12-31',
        'local': 'Clube XYZ',
        'imagem': '',
      }),
      'purchase_ticketCounts': jsonEncode({'Pista': 2, 'VIP': 1}),
    });

    await pumpPage(tester);
    await tester.pumpAndSettle();

    expect(find.text('Festa Teste'), findsOneWidget);
    expect(find.text('2x Pista'), findsOneWidget);
    expect(find.text('1x VIP'), findsOneWidget);
    expect(find.textContaining('Total (3 ingressos)'), findsOneWidget);
  });

  testWidgets('Erro se não houver dados de evento ao confirmar compra', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await pumpPage(tester);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nome completo'),
      'Teste',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'CPF'),
      '12345678900',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'E-mail'),
      'teste@email.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Telefone'),
      '11999999999',
    );

    await tester.tap(find.text('Confirmar Compra'));
    await tester.pump();

    expect(find.text('Erro'), findsOneWidget);
    expect(
      find.text('Dados do evento ou ingressos não disponíveis.'),
      findsOneWidget,
    );

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Erro'), findsNothing);
  });

  testWidgets('Confirmação limpa dados e mostra diálogo de sucesso', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({
      'purchase_eventoData': jsonEncode({
        'id': '1',
        'nome': 'Festa Teste',
        'data': '2025-12-31',
        'local': 'Clube XYZ',
        'imagem': '',
      }),
      'purchase_ticketCounts': jsonEncode({'Pista': 1}),
    });

    await pumpPage(tester);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nome completo'),
      'Teste',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'CPF'),
      '12345678900',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'E-mail'),
      'teste@email.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Telefone'),
      '11999999999',
    );

    await tester.tap(find.text('Confirmar Compra'));
    await tester.pumpAndSettle();

    expect(find.text('Compra confirmada!'), findsOneWidget);
    expect(
      find.text('Seus ingressos foram adicionados ao carrinho.'),
      findsOneWidget,
    );

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Compra confirmada!'), findsNothing);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('purchase_eventoData'), isNull);
    expect(prefs.getString('purchase_ticketCounts'), isNull);
  });
}
