import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_tixup/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/features/auth/presentation/pages/login_page.dart';
import 'package:mobile_tixup/viewmodels/login_viewmodel.dart';
import 'package:mobile_tixup/features/auth/services/auth_gate.dart';

class TestLoginViewModel extends LoginViewModel {
  bool shouldSucceed;

  TestLoginViewModel({this.shouldSucceed = true});

  @override
  Future<UserModel?> login(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 100));
    isLoading = false;
    notifyListeners();

    if (shouldSucceed) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthGate()),
        );
      }
      return null;
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro: Email ou senha inválidos.')),
        );
      }
      throw Exception('Email ou senha inválidos.');
    }
  }
}

void main() {
  group('LoginScreen Tests', () {
    Widget createTestWidget({required LoginViewModel viewModel}) {
      return MaterialApp(
        home: ChangeNotifierProvider<LoginViewModel>.value(
          value: viewModel,
          child: const LoginScreen(),
        ),
      );
    }

    testWidgets('deve exibir TextFields para email e senha', (tester) async {
      final viewModel = TestLoginViewModel();
      await tester.pumpWidget(createTestWidget(viewModel: viewModel));

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Senha'), findsOneWidget);
    });

    testWidgets('deve permitir preenchimento dos campos de email e senha', (tester) async {
      final viewModel = TestLoginViewModel();
      await tester.pumpWidget(createTestWidget(viewModel: viewModel));

      final emailField = find.widgetWithText(TextField, 'Email');
      final passwordField = find.widgetWithText(TextField, 'Senha');

      await tester.enterText(emailField, 'teste@exemplo.com');
      await tester.enterText(passwordField, 'senha123');
      await tester.pump();

      expect(viewModel.emailController.text, 'teste@exemplo.com');
      expect(viewModel.passwordController.text, 'senha123');
    });

    testWidgets('deve alternar visibilidade da senha ao clicar no ícone', (tester) async {
      final viewModel = TestLoginViewModel();
      await tester.pumpWidget(createTestWidget(viewModel: viewModel));

      expect(viewModel.obscureText, true);
      final visibilityIcon = find.byIcon(Icons.visibility);
      expect(visibilityIcon, findsOneWidget);

      await tester.tap(visibilityIcon);
      await tester.pump();

      expect(viewModel.obscureText, false);
    });

    testWidgets('deve navegar para AuthGate após login bem-sucedido', (tester) async {
      final viewModel = TestLoginViewModel(shouldSucceed: true);
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<LoginViewModel>.value(
            value: viewModel,
            child: const LoginScreen(),
          ),
          routes: {
            '/auth': (context) => const AuthGate(),
          },
        ),
      );

      final emailField = find.widgetWithText(TextField, 'Email');
      final passwordField = find.widgetWithText(TextField, 'Senha');
      final loginButton = find.widgetWithText(ElevatedButton, 'Entrar');

      await tester.enterText(emailField, 'teste@exemplo.com');
      await tester.enterText(passwordField, 'senha123');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      expect(find.byType(AuthGate), findsOneWidget);
    });

    testWidgets('deve exibir SnackBar ao simular falha no login', (tester) async {
      final viewModel = TestLoginViewModel(shouldSucceed: false);
      await tester.pumpWidget(createTestWidget(viewModel: viewModel));

      final emailField = find.widgetWithText(TextField, 'Email');
      final passwordField = find.widgetWithText(TextField, 'Senha');
      final loginButton = find.widgetWithText(ElevatedButton, 'Entrar');

      await tester.enterText(emailField, 'teste@exemplo.com');
      await tester.enterText(passwordField, 'senha123');
      await tester.tap(loginButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Erro: Email ou senha inválidos.'), findsOneWidget);
    });

    testWidgets('deve exibir CircularProgressIndicator quando isLoading for true', (tester) async {
      final viewModel = TestLoginViewModel();
      await tester.pumpWidget(createTestWidget(viewModel: viewModel));

      viewModel.isLoading = true;
      viewModel.notifyListeners();
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Entrar'), findsNothing);
    });
  });
}