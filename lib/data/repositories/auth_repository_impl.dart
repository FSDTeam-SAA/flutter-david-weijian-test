// data/repositories/auth_repository_impl.dart
import 'package:david_weijian_test/core/constants/api_constants.dart';
import 'package:david_weijian_test/core/network/api_client.dart';
import 'package:david_weijian_test/core/services/secure_storage_service.dart';
import 'package:david_weijian_test/data/models/auth/auth_model.dart';
import 'package:david_weijian_test/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SecureStorageService storage;

  AuthRepositoryImpl({ required this.storage});

  @override
  Future<void> logout() async {
    await storage.deleteAccessToken();
  }

  @override
  Future<AuthResponse> login(String email, String password) async {
    final response = await 
    ApiClient.post(
      ApiConstants.adminLoginEndpoint,
      {'email': email, 'password': password},
    );
    
    return AuthResponse.fromJson(response.data);
  }
}