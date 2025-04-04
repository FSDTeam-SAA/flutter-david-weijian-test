
import 'package:david_weijian_test/core/network/api_client.dart';
import 'package:david_weijian_test/core/routes/app_routes.dart';
import 'package:david_weijian_test/core/services/secure_storage_service.dart';
import 'package:david_weijian_test/data/repositories/auth_repository_impl.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final SecureStorageService _secureStorage = SecureStorageService();
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var accessToken = ''.obs;

  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl(
    storage: SecureStorageService(),
    apiClient: ApiClient(),
  );

  @override
  void onInit() {
    checkLoginStatus();
    super.onInit();
  }

  // Check if the user is already logged in
  Future<void> checkLoginStatus() async {
    isLoading(true);
    final token = await _secureStorage.getAccessToken();
    if (token != null) {
      isLoggedIn(true);
      accessToken(token);
    }
    isLoading(false);
  }

  // Admin login
  Future<void> adminLogin(String email, String password) async {
    try {
      isLoading(true);
      final response = await _authRepository.login(email, password);
      if (response.status) {
        isLoggedIn(true);
        accessToken(response.accessToken ?? '');
        await _secureStorage.saveAccessToken(
          response.accessToken!,
        ); // Save token
        Get.offAllNamed(Routes.dashboard);
      } else {
        Get.snackbar('Error', response.message);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Logout the admin
  Future<void> logout() async {
    isLoggedIn(false);
    accessToken('');
    await _secureStorage.deleteAccessToken(); // Delete token
    Get.offAllNamed(Routes.login);
  }
}
