import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/auth/presentation/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJuam5uZXBseG9tb2tpZW9mcmRxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI0MTA1MDQsImV4cCI6MjA1Nzk4NjUwNH0.KA0De-qj8yoMzAdEZlIsvB2CAwT3D1W60cJ1lq_cvl4",
    url: "https://bnjnneplxomokieofrdq.supabase.co",
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TixUp',
      theme: ThemeData(
        primaryColor: Colors.orange[300],
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginScreen(), // login inicial
    );
  }
}
