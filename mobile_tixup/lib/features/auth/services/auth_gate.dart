import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/auth/presentation/pages/login_page.dart';
import 'package:mobile_tixup/models/user_provider.dart';
import 'package:mobile_tixup/widgets/nav_menu.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    if (user != null) {
      return const NavigationMenu();
    } else {
      return const LoginScreen();
    }
  }
}
