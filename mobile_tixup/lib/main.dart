import 'package:flutter/material.dart';
import 'nav_menu.dart'; // Importe o NavigationMenu

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:
          NavigationMenu(), // Aqui você define o NavigationMenu como tela inicial
    );
  }
}
