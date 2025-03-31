import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/auth/services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  final authService = AuthService();
  final _emailController = TextEditingController();

  Future<void> _resetPassword() async {
    final email = _emailController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha o campo de email.")),
      );
      return;
    }

    try {
      await authService.resetPassword(email);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "E-mail de recuperação enviado. Verifique sua caixa de entrada!",
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 245),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                    color: Color.fromARGB(206, 0, 0, 0),
                  ),
                  children: [
                    TextSpan(
                      text: 'Se divertiu tanto',
                      style: TextStyle(letterSpacing: -1),
                    ),
                    TextSpan(text: ' '), // Espaço entre as palavras
                    TextSpan(
                      text: 'que esqueceu',
                      style: TextStyle(letterSpacing: -1),
                    ),
                    TextSpan(text: ' '),
                    TextSpan(
                      text: 'sua senha?',
                      style: TextStyle(letterSpacing: -1),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(
                  color: Color.fromARGB(206, 0, 0, 0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(206, 0, 0, 0),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.deepOrange,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 9.0,
                  horizontal: 10.0,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(206, 231, 87, 47),
                padding: const EdgeInsets.symmetric(
                  vertical: 13.0,
                  horizontal: 160.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text(
                'Enviar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
