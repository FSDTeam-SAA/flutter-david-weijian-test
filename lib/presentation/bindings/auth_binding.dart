import 'package:david_weijian_test/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    // Lazy load the LoginController when it's needed
    Get.lazyPut(() => AuthController());
  }
}