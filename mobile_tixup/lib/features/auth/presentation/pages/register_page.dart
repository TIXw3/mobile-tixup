import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobile_tixup/features/auth/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../../../../models/user_model.dart';
import '../../../../models/user_provider.dart';
import 'package:mobile_tixup/viewmodels/register_viewmodel.dart';

class TelaRegistro extends StatelessWidget {
  const TelaRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: const _TelaRegistroBody(),
    );
  }
}

class _TelaRegistroBody extends StatelessWidget {
  const _TelaRegistroBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 245),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
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
                      const TextSpan(text: 'Cadastre-se e '),
                      const TextSpan(text: 'encontre novas '),
                      TextSpan(
                        text: 'experiências!',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 249, 115, 22),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: viewModel.fullNameController,
                decoration: InputDecoration(
                  labelText: 'Nome Completo',
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
                  suffixIcon: const Icon(
                    Icons.person,
                    color: Color.fromARGB(206, 0, 0, 0),
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
                  suffixIcon: const Icon(
                    Icons.mail,
                    color: Color.fromARGB(206, 0, 0, 0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: viewModel.passwordController,
                obscureText: viewModel.obscureText,
                decoration: InputDecoration(
                  labelText: 'Senha',
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
                    vertical: 9,
                    horizontal: 10,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      viewModel.obscureText
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color.fromARGB(206, 0, 0, 0),
                    ),
                    onPressed: viewModel.togglePasswordVisibility,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: viewModel.confirmPasswordController,
                obscureText: viewModel.obscureText,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
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
                  suffixIcon: IconButton(
                    icon: Icon(
                      viewModel.obscureText
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color.fromARGB(206, 0, 0, 0),
                    ),
                    onPressed: viewModel.togglePasswordVisibility,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: viewModel.birthDateController,
                inputFormatters: [viewModel.birthDateFormatter],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento',
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
                    vertical: 9,
                    horizontal: 10,
                  ),
                  suffixIcon: const Icon(
                    Icons.cake,
                    color: Color.fromARGB(206, 0, 0, 0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: viewModel.cpfController,
                inputFormatters: [viewModel.cpfFormatter],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'CPF',
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
                    vertical: 9,
                    horizontal: 10,
                  ),
                  suffixIcon: const Icon(
                    Icons.badge,
                    color: Color.fromARGB(206, 0, 0, 0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: viewModel.phoneController,
                inputFormatters: [viewModel.phoneFormatter],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Telefone',
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
                    vertical: 9,
                    horizontal: 10,
                  ),
                  suffixIcon: const Icon(
                    Icons.phone,
                    color: Color.fromARGB(206, 0, 0, 0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      viewModel.isLoading
                          ? null
                          : () async {
                            try {
                              final user = await viewModel.signUp(context);
                              if (user != null && context.mounted) {
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Erro ao criar conta: ${e.toString()}',
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 249, 115, 22),
                    padding: const EdgeInsets.symmetric(
                      vertical: 13.0,
                      horizontal: 20.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child:
                      viewModel.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            'Criar',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                            ),
                          ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
