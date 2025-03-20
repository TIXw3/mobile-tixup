import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/home/home_page.dart';
import 'package:mobile_tixup/widgets/nav_menu.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationMenu(), //
    );
  }
}
