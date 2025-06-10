import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/auth/services/auth_service.dart';
import 'package:mobile_tixup/models/user_provider.dart';
import 'package:mobile_tixup/features/auth/presentation/pages/login_page.dart';
import 'package:provider/provider.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService authService = AuthService();

  Future<void> logout(BuildContext context) async {
    try {
      await authService.signOut();
      Provider.of<UserProvider>(context, listen: false).setUser(null);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao sair: $e')));
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    await authService.signOut();
    Navigator.of(context).pop();
  }
}
