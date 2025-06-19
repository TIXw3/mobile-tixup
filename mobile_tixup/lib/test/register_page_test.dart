import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/features/auth/presentation/pages/register_page.dart';
import 'package:mobile_tixup/viewmodels/register_viewmodel.dart';
import 'package:mobile_tixup/models/user_model.dart';
import 'package:mobile_tixup/models/user_provider.dart';

class MockAuthService {
  bool shouldFail = false;
  String? errorMessage;
  String? userIdToReturn;

  Future<String> signUp({
    required String nome,
    required String email,
    required String password,
    required String cpf,
    required String dataNascimento,
    required String telefone,
    String tipo = 'user',
  }) async {
    if (shouldFail) {
      throw Exception(errorMessage ?? 'Erro de registro');
    }
    return userIdToReturn ?? '1';
  }
}

class TestRegisterViewModel extends RegisterViewModel {
  TestRegisterViewModel(MockAuthService mockAuthService)
      : super(authService: mockAuthService as dynamic);
  @override
  Future<UserModel?> signUp(BuildContext context) => super.signUp(context);
}

void main() {
  group('TelaRegistro', () {
    late MockAuthService mockAuthService;
    late UserProvider userProvider;

    Widget createWidgetUnderTest() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>.value(value: userProvider),
          ChangeNotifierProvider<RegisterViewModel>(
            create: (_) => TestRegisterViewModel(mockAuthService),
          ),
        ],
        child: const MaterialApp(home: TelaRegistro()),
      );
    }

    setUp(() {
      mockAuthService = MockAuthService();
      userProvider = UserProvider();
    });

    testWidgets('Registro com sucesso seta usuário', (tester) async {
      mockAuthService.userIdToReturn = '42';
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.enterText(find.byType(TextField).at(0), 'Nome Completo');
      await tester.enterText(find.byType(TextField).at(1), 'teste@email.com');
      await tester.enterText(find.byType(TextField).at(2), 'senha123');
      await tester.enterText(find.byType(TextField).at(3), 'senha123');
      await tester.enterText(find.byType(TextField).at(4), '01/01/2000');
      await tester.enterText(find.byType(TextField).at(5), '123.456.789-09');
      await tester.enterText(find.byType(TextField).at(6), '(11) 99999-9999');
      await tester.tap(find.text('Criar'));
      await tester.pumpAndSettle();
      expect(userProvider.user, isNotNull);
      expect(userProvider.user!.id, '42');
    });

    testWidgets('Exibe erro se campos obrigatórios não preenchidos', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.text('Criar'));
      await tester.pump();
      expect(find.textContaining('Preencha todos os campos'), findsOneWidget);
    });

    testWidgets('Exibe erro se senhas não coincidem', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.enterText(find.byType(TextField).at(0), 'Nome Completo');
      await tester.enterText(find.byType(TextField).at(1), 'teste@email.com');
      await tester.enterText(find.byType(TextField).at(2), 'senha123');
      await tester.enterText(find.byType(TextField).at(3), 'diferente');
      await tester.enterText(find.byType(TextField).at(4), '01/01/2000');
      await tester.enterText(find.byType(TextField).at(5), '123.456.789-09');
      await tester.enterText(find.byType(TextField).at(6), '(11) 99999-9999');
      await tester.tap(find.text('Criar'));
      await tester.pump();
      expect(find.textContaining('As senhas não coincidem'), findsOneWidget);
    });

    testWidgets('Exibe erro se CPF inválido', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.enterText(find.byType(TextField).at(0), 'Nome Completo');
      await tester.enterText(find.byType(TextField).at(1), 'teste@email.com');
      await tester.enterText(find.byType(TextField).at(2), 'senha123');
      await tester.enterText(find.byType(TextField).at(3), 'senha123');
      await tester.enterText(find.byType(TextField).at(4), '01/01/2000');
      await tester.enterText(find.byType(TextField).at(5), '000.000.000-00');
      await tester.enterText(find.byType(TextField).at(6), '(11) 99999-9999');
      await tester.tap(find.text('Criar'));
      await tester.pump();
      expect(find.textContaining('CPF inválido'), findsOneWidget);
    });

    testWidgets('Exibe erro se data de nascimento inválida', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.enterText(find.byType(TextField).at(0), 'Nome Completo');
      await tester.enterText(find.byType(TextField).at(1), 'teste@email.com');
      await tester.enterText(find.byType(TextField).at(2), 'senha123');
      await tester.enterText(find.byType(TextField).at(3), 'senha123');
      await tester.enterText(find.byType(TextField).at(4), '99/99/9999');
      await tester.enterText(find.byType(TextField).at(5), '123.456.789-09');
      await tester.enterText(find.byType(TextField).at(6), '(11) 99999-9999');
      await tester.tap(find.text('Criar'));
      await tester.pump();
      expect(find.textContaining('Data de nascimento inválida'), findsOneWidget);
    });

    testWidgets('Alterna visibilidade da senha', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      final senhaField = find.byType(TextField).at(2);
      expect(
        tester.widget<TextField>(senhaField).obscureText,
        isTrue,
      );
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();
      expect(
        tester.widget<TextField>(senhaField).obscureText,
        isFalse,
      );
    });
  });
} 