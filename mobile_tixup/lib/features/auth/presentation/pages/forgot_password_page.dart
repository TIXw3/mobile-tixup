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
  final _tokenController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _isTokenSent = false;
  bool _isLoading = false;

  Future<void> _initiateResetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha o campo de email.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final token = await authService.initiatePasswordReset(email);

      // enviar o token por emaial via edge function
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Token de recuperação gerado: $token. Use-o para redefinir sua senha.",
          ),
        ),
      );

      setState(() {
        _isTokenSent = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro: ${e.toString()}")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _resetPassword() async {
    final token = _tokenController.text.trim();
    final newPassword = _newPasswordController.text.trim();

    if (token.isEmpty || newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await authService.resetPassword(token, newPassword);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Senha redefinida com sucesso! Faça login."),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro: ${e.toString()}")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 245),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
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
                              TextSpan(text: ' '),
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
                            fontWeight: FontWeight.bold,
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
                      if (_isTokenSent) ...[
                        const SizedBox(height: 20),
                        TextField(
                          controller: _tokenController,
                          decoration: InputDecoration(
                            labelText: 'Token de Recuperação',
                            labelStyle: const TextStyle(
                              color: Color.fromARGB(206, 0, 0, 0),
                              fontWeight: FontWeight.bold,
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
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _newPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Nova Senha',
                            labelStyle: const TextStyle(
                              color: Color.fromARGB(206, 0, 0, 0),
                              fontWeight: FontWeight.bold,
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
                        ),
                      ],
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              _isLoading
                                  ? null
                                  : (_isTokenSent
                                      ? _resetPassword
                                      : _initiateResetPassword),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              249,
                              115,
                              22,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 13.0,
                              horizontal: 20.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          child:
                              _isLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    _isTokenSent ? 'Redefinir Senha' : 'Enviar',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      letterSpacing: 0,
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
