import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_tixup/features/auth/services/auth_service.dart';
import 'package:mobile_tixup/models/user_model.dart';

class MockSupabaseClient {}

void main() {
  group('AuthService', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    test('login throws exception for invalid credentials', () async {
      expect(
        () async => await authService.login('invalid@email.com', 'wrongpass'),
        throwsException,
      );
    });
  });
}
