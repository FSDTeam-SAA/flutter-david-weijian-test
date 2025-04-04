
import 'package:david_weijian_test/core/constants/key_constants.dart';
import 'package:david_weijian_test/core/routes/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 3));
    debugPrint("Checking authentication status...");

    String? token = await _storage.read(key: KeyConstants.accessToken);

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(Routes.dashboard);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}
