import 'package:david_weijian_test/core/network/api_client.dart';
import 'package:david_weijian_test/data/repositories/bug_report_repository_impl.dart';
import 'package:david_weijian_test/data/repositories/route_repository_impl.dart';
import 'package:david_weijian_test/data/repositories/test_centre_repository_impl.dart';
import 'package:david_weijian_test/data/repositories/user_repositor_impl.dart';
import 'package:david_weijian_test/domain/repositories/bug_report_repository.dart';
import 'package:david_weijian_test/domain/repositories/route_repository.dart';
import 'package:david_weijian_test/domain/repositories/test_centre_repository.dart';
import 'package:david_weijian_test/domain/repositories/user_repository.dart';
import 'package:david_weijian_test/presentation/controllers/bug_report_controller.dart';
import 'package:david_weijian_test/presentation/controllers/content_controller.dart';
import 'package:david_weijian_test/presentation/controllers/navbar_controller.dart';
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

    // Setup repositories
    Get.lazyPut<TestCentreRepository>(
      () => TestCentreRepositoryImpl(apiClient: Get.find<ApiClient>()),
      fenix: true,
    );

    Get.lazyPut<RouteRepository>(
      () => RouteRepositoryImpl(apiClient: Get.find<ApiClient>()),
      fenix: true,
    );

    // Setup controller
    Get.lazyPut<ContentController>(
      () => ContentController(
        testCentreRepo: Get.find<TestCentreRepository>(),
        routeRepo: Get.find<RouteRepository>(),
      ),
    );

    Get.lazyPut<SidebarController>(() => SidebarController());
  }
}
