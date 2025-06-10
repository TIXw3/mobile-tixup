import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/auth/services/auth_service.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  bool isTokenSent = false;
  bool isLoading = false;

  Future<String?> initiateResetPassword(BuildContext context) async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      throw Exception('Preencha o campo de email.');
    }
    isLoading = true;
    notifyListeners();
    try {
      final token = await authService.initiatePasswordReset(email);
      isTokenSent = true;
      notifyListeners();
      return token;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    final token = tokenController.text.trim();
    final newPassword = newPasswordController.text.trim();
    if (token.isEmpty || newPassword.isEmpty) {
      throw Exception('Preencha todos os campos.');
    }
    isLoading = true;
    notifyListeners();
    try {
      await authService.resetPassword(token, newPassword);
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    tokenController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }
} 