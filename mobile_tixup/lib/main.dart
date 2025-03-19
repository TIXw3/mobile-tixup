import 'package:flutter/material.dart';
import 'package:mobile_tixup/pages/home.dart';
import 'nav_menu.dart'; // Importe o NavigationMenu

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TopAppBar(), // Aqui você define o NavigationMenu como tela inicial
    );
  }
}
