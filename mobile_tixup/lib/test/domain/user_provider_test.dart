import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_tixup/models/user_provider.dart';
import 'package:mobile_tixup/models/user_model.dart';

void main() {
  group('UserProvider', () {
    late UserProvider provider;
    late UserModel user;
    late int notifyCount;

    setUp(() {
      provider = UserProvider();
      user = UserModel(
        id: '1',
        nome: 'Test',
        email: 'test@email.com',
        telefone: '11999999999',
        dataNascimento: '2000-01-01',
        cpf: '12345678900',
        endereco: 'Rua Teste, 123',
      );
      notifyCount = 0;
      provider.addListener(() {
        notifyCount++;
      });
    });

    test('setUser sets user and notifies listeners', () {
      provider.setUser(user);
      expect(provider.user, isNotNull);
      expect(provider.user!.id, '1');
      expect(notifyCount, 1);
    });

    test('clearUser clears user and notifies listeners', () {
      provider.setUser(user);
      notifyCount = 0; // reset
      provider.clearUser();
      expect(provider.user, isNull);
      expect(notifyCount, 1);
    });

    test('setUser(null) clears user and notifies listeners', () {
      provider.setUser(null);
      expect(provider.user, isNull);
      expect(notifyCount, 1);
    });
  });
}
