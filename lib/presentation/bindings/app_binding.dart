import 'package:david_weijian_test/core/network/api_client.dart';
import 'package:david_weijian_test/data/repositories/user_repositor_impl.dart';
import 'package:david_weijian_test/domain/repositories/user_repository.dart';
import 'package:david_weijian_test/presentation/controllers/user_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Permanent instances
    Get.put<ApiClient>(ApiClient(), permanent: true);
    
    // Lazy instances
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(apiClient: Get.find<ApiClient>()),
      fenix: true,
    );
    
    Get.lazyPut<UserController>(
      () => UserController(userRepository: Get.find<UserRepository>()),
    );
  }
}