import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/auth/services/auth_service.dart';
import 'package:mobile_tixup/models/user_model.dart';
import 'package:mobile_tixup/models/user_provider.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService authService;

  LoginViewModel({AuthService? authService}) : authService = authService ?? AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool isLoading = false;

  Future<UserModel?> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    isLoading = true;
    notifyListeners();
    try {
      final user = await authService.login(email, password);
      if (user != null) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(user);
        return user;
      } else {
        throw Exception('Email ou senha inválidos.');
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void togglePasswordVisibility() {
    obscureText = !obscureText;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
} 