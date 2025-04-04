import 'package:david_weijian_test/data/models/auth/auth_model.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(String email, String password);
  Future<void> logout();
}