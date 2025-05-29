import 'package:mobile_tixup/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<String> signUpEmailPassword(String email, String password) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );
    if (response.user == null) {
      throw Exception('Erro ao criar usuário');
    }
    return response.user!.id;
  }

  Future<void> addUserToTable({
    required String id,
    required String nome,
    required String email,
    required String cpf,
    required String dataNascimento,
    required String telefone,
  }) async {
    final response =
        await supabase.from('usuarios').insert({
          'id': id,
          'nome': nome,
          'email': email,
          'cpf': cpf,
          'datanascimento': dataNascimento,
          'telefone': telefone,
          'endereco': '',
          'imagem_perfil': '',
        }).select();

    if (response.isEmpty) {
      throw Exception('Erro ao salvar dados do usuário na tabela');
    }
  }

  Future<UserModel?> getUserById(String id) async {
    final response =
        await supabase.from('usuarios').select().eq('id', id).single();

    if (response == null) return null;

    return UserModel.fromMap(response);
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<String?> login(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.user?.id;
  }

  Future<void> resetPassword(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw Exception('Erro ao enviar e-mail de recuperação: $e');
    }
  }
}
