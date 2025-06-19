import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/features/auth/presentation/pages/login_page.dart';
import 'package:mobile_tixup/viewmodels/login_viewmodel.dart';
import 'package:mobile_tixup/models/user_model.dart';
import 'package:mobile_tixup/models/user_provider.dart';

class MockAuthService {
  bool shouldFail = false;
  UserModel? userToReturn;
  String? errorMessage;

  Future<UserModel?> login(String email, String password) async {
    if (shouldFail) {
      throw Exception(errorMessage ?? 'Erro de login');
    }
    return userToReturn;
  }
}

class TestLoginViewModel extends LoginViewModel {
  TestLoginViewModel(MockAuthService mockAuthService)
      : super(authService: mockAuthService as dynamic);
  @override
  Future<UserModel?> login(BuildContext context) => super.login(context);
}

void main() {
  group('LoginScreen', () {
    late MockAuthService mockAuthService;
    late UserProvider userProvider;

    Widget createWidgetUnderTest() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>.value(value: userProvider),
          ChangeNotifierProvider<LoginViewModel>(
            create: (_) => TestLoginViewModel(mockAuthService),
          ),
        ],
        child: const MaterialApp(home: LoginScreen()),
      );
    }

    setUp(() {
      mockAuthService = MockAuthService();
      userProvider = UserProvider();
    });

    testWidgets('Login com sucesso navega e seta usuário', (tester) async {
      final user = UserModel(
        id: '1',
        nome: 'Teste',
        email: 'teste@email.com',
        telefone: '11999999999',
        dataNascimento: '01/01/2000',
        cpf: '12345678900',
        endereco: 'Rua Teste',
      );
      mockAuthService.userToReturn = user;
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.enterText(find.byType(TextField).at(0), 'teste@email.com');
      await tester.enterText(find.byType(TextField).at(1), 'senha123');
      await tester.tap(find.text('Entrar'));
      await tester.pumpAndSettle();
      expect(userProvider.user, isNotNull);
      expect(userProvider.user!.email, 'teste@email.com');
    });

    testWidgets('Exibe erro ao falhar login', (tester) async {
      mockAuthService.shouldFail = true;
      mockAuthService.errorMessage = 'Credenciais inválidas';
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.enterText(find.byType(TextField).at(0), 'errado@email.com');
      await tester.enterText(find.byType(TextField).at(1), 'errado');
      await tester.tap(find.text('Entrar'));
      await tester.pump();
      expect(find.textContaining('Erro'), findsOneWidget);
    });

    testWidgets('Alterna visibilidade da senha', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      final senhaField = find.byType(TextField).at(1);
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