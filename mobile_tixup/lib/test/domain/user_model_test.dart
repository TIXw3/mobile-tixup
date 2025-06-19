import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_tixup/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('fromMap and toMap with all fields', () {
      final map = {
        'id': '1',
        'nome': 'Test',
        'email': 'test@email.com',
        'telefone': '11999999999',
        'datanascimento': '2000-01-01',
        'cpf': '12345678900',
        'endereco': 'Rua Teste, 123',
      };
      final user = UserModel.fromMap(map);
      expect(user.id, '1');
      expect(user.nome, 'Test');
      expect(user.email, 'test@email.com');
      expect(user.telefone, '11999999999');
      expect(user.dataNascimento, '2000-01-01');
      expect(user.cpf, '12345678900');
      expect(user.endereco, 'Rua Teste, 123');
      expect(user.toMap(), map);
    });

    test('fromMap with missing fields uses default empty string', () {
      final map = <String, dynamic>{};
      final user = UserModel.fromMap(map);
      expect(user.id, '');
      expect(user.nome, '');
      expect(user.email, '');
      expect(user.telefone, '');
      expect(user.dataNascimento, '');
      expect(user.cpf, '');
      expect(user.endereco, '');
    });

    test('imagemPerfil getter returns null', () {
      final user = UserModel(
        id: '1',
        nome: 'Test',
        email: 'test@email.com',
        telefone: '11999999999',
        dataNascimento: '2000-01-01',
        cpf: '12345678900',
        endereco: 'Rua Teste, 123',
      );
      expect(user.imagemPerfil, isNull);
    });
  });
}
