import 'package:bcrypt/bcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:mobile_tixup/models/user_model.dart';

class AuthService {
  final supabase = Supabase.instance.client;
  final uuid = Uuid();

  Future<String> signUp({
    required String nome,
    required String email,
    required String password,
    required String cpf,
    required String dataNascimento,
    required String telefone,
    String tipo = 'user',
  }) async {
    final emailCheck =
        await supabase
            .from('usuarios')
            .select()
            .eq('email', email)
            .maybeSingle();
    if (emailCheck != null) {
      throw Exception('Email já registrado.');
    }

    final cpfCheck =
        await supabase.from('usuarios').select().eq('cpf', cpf).maybeSingle();
    if (cpfCheck != null) {
      throw Exception('CPF já registrado.');
    }

    final hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
    final userId = uuid.v4();

    final response =
        await supabase
            .from('usuarios')
            .insert({
              'id': userId,
              'nome': nome,
              'email': email,
              'senha': hashedPassword,
              'tipo': 'usuario',
              'cpf': cpf,
              'datanascimento': dataNascimento,
              'telefone': telefone,
            })
            .select()
            .single();

    if (response.isEmpty) {
      throw Exception('Erro ao salvar dados do usuário na tabela.');
    }

    return userId;
  }

  Future<UserModel?> login(String email, String password) async {
    final response =
        await supabase
            .from('usuarios')
            .select()
            .eq('email', email)
            .maybeSingle();

    if (response == null) {
      throw Exception('Email ou senha inválidos.');
    }

    final hashedPassword = response['senha'] as String;
    final isPasswordValid = BCrypt.checkpw(password, hashedPassword);

    if (!isPasswordValid) {
      throw Exception('Email ou senha inválidos.');
    }

    return UserModel.fromMap(response);
  }

  Future<UserModel?> getUserById(String id) async {
    final response =
        await supabase.from('usuarios').select().eq('id', id).maybeSingle();

    if (response == null) return null;

    return UserModel.fromMap(response);
  }

  Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId');
    } catch (e) {
      throw Exception('Erro ao limpar dados locais: $e');
    }
  }

  Future<String> initiatePasswordReset(String email) async {
    final user =
        await supabase
            .from('usuarios')
            .select()
            .eq('email', email)
            .maybeSingle();

    if (user == null) {
      throw Exception('Email não encontrado.');
    }

    final token = uuid.v4();
    final expiresAt = DateTime.now().add(Duration(hours: 1)).toIso8601String();

    await supabase.from('reset_tokens').insert({
      'token': token,
      'email': email,
      'expires_at': expiresAt,
    });

    // edge function via supa
    return token;
  }

  Future<void> resetPassword(String token, String newPassword) async {
    final tokenData =
        await supabase
            .from('reset_tokens')
            .select()
            .eq('token', token)
            .maybeSingle();

    if (tokenData == null) {
      throw Exception('Token inválido ou expirado.');
    }

    final expiresAt = DateTime.parse(tokenData['expires_at'] as String);
    if (expiresAt.isBefore(DateTime.now())) {
      throw Exception('Token expirado.');
    }

    final email = tokenData['email'] as String;

    final hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
    await supabase
        .from('usuarios')
        .update({'senha': hashedPassword})
        .eq('email', email);

    await supabase.from('reset_tokens').delete().eq('token', token);
  }
}
