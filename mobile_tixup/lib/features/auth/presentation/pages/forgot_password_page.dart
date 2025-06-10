import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/auth/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:mobile_tixup/viewmodels/forgot_password_viewmodel.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordViewModel(),
      child: const _ForgotPasswordBody(),
    );
  }
}

class _ForgotPasswordBody extends StatelessWidget {
  const _ForgotPasswordBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ForgotPasswordViewModel>(context);
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
                        controller: viewModel.emailController,
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
                      if (viewModel.isTokenSent) ...[
                        const SizedBox(height: 20),
                        TextField(
                          controller: viewModel.tokenController,
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
                          controller: viewModel.newPasswordController,
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
                          onPressed: viewModel.isLoading
                              ? null
                              : () async {
                                  try {
                                    if (viewModel.isTokenSent) {
                                      await viewModel.resetPassword(context);
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Senha redefinida com sucesso! Faça login."),
                                          ),
                                        );
                                        Navigator.pop(context);
                                      }
                                    } else {
                                      final token = await viewModel.initiateResetPassword(context);
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Token de recuperação gerado: $token. Use-o para redefinir sua senha.",
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Erro: ${e.toString()}")),
                                      );
                                    }
                                  }
                                },
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
                          child: viewModel.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  viewModel.isTokenSent ? 'Redefinir Senha' : 'Enviar',
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
