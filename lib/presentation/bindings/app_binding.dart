import 'package:david_weijian_test/core/network/api_client.dart';
import 'package:david_weijian_test/data/repositories/bug_report_repository_impl.dart';
import 'package:david_weijian_test/data/repositories/user_repositor_impl.dart';
import 'package:david_weijian_test/domain/repositories/bug_report_repository.dart';
import 'package:david_weijian_test/domain/repositories/user_repository.dart';
import 'package:david_weijian_test/presentation/controllers/bug_report_controller.dart';
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

    Get.lazyPut<BugReportRepository>(
    () => BugReportRepositoryImpl(apiClient: Get.find<ApiClient>()),
    fenix: true,
  );
  
  Get.lazyPut<BugReportController>(
    () => BugReportController(repository: Get.find<BugReportRepository>()),
  );
  }
}