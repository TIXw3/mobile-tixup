import 'package:flutter/material.dart';
import 'package:mobile_tixup/features/auth/services/auth_service.dart';
import 'package:mobile_tixup/models/user_model.dart';
import 'package:mobile_tixup/models/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthService authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final birthDateFormatter = MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  final cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  final phoneFormatter = MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  bool obscureText = true;
  bool isLoading = false;

  void togglePasswordVisibility() {
    obscureText = !obscureText;
    notifyListeners();
  }

  bool verifyCPF(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    if (cpf.length != 11 || cpf.split('').every((e) => e == cpf[0])) {
      return false;
    }
    int soma1 = 0;
    for (int i = 0; i < 9; i++) {
      soma1 += int.parse(cpf[i]) * (10 - i);
    }
    int dv1 = 11 - (soma1 % 11);
    if (dv1 == 10 || dv1 == 11) dv1 = 0;
    int soma2 = 0;
    for (int i = 0; i < 9; i++) {
      soma2 += int.parse(cpf[i]) * (11 - i);
    }
    soma2 += dv1 * 2;
    int dv2 = 11 - (soma2 % 11);
    if (dv2 == 10 || dv2 == 11) dv2 = 0;
    return cpf[9] == dv1.toString() && cpf[10] == dv2.toString();
  }

  bool isValidDate(String date) {
    final parts = date.split('/');
    if (parts.length != 3) return false;
    
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    
    if (day == null || month == null || year == null) return false;
    if (year < 1900 || month < 1 || month > 12) return false;
    
    // Check if the day is valid for the given month
    final daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (month == 2 && year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
      // February in leap year
      if (day < 1 || day > 29) return false;
    } else {
      if (day < 1 || day > daysInMonth[month - 1]) return false;
    }
    
    return true;
  }

  Future<UserModel?> signUp(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final cpf = cpfController.text.trim();
    final birthDate = birthDateController.text.trim();
    final nome = fullNameController.text.trim();
    final telefone = phoneController.text.trim();
    isLoading = true;
    notifyListeners();
    try {
      if (nome.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty || birthDate.isEmpty || cpf.isEmpty || telefone.isEmpty) {
        throw Exception('Preencha todos os campos');
      }
      if (password != confirmPassword) {
        throw Exception('As senhas não coincidem');
      }
      if (!verifyCPF(cpf)) {
        throw Exception('CPF inválido');
      }
      if (!isValidDate(birthDate)) {
        throw Exception('Data de nascimento inválida. Use o formato DD/MM/AAAA');
      }
      final formattedName = nome.split(' ').map((word) => 
        word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1).toLowerCase()
      ).join(' ');

      final userId = await authService.signUp(
        nome: formattedName,
        email: email,
        password: password,
        cpf: cpf,
        dataNascimento: birthDate,
        telefone: telefone,
      );
      final user = UserModel(
        id: userId,
        nome: formattedName,
        email: email,
        telefone: telefone,
        dataNascimento: birthDate,
        cpf: cpf,
        endereco: '',
      );
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(user);
      return user;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    birthDateController.dispose();
    cpfController.dispose();
    phoneController.dispose();
    super.dispose();
  }
} 