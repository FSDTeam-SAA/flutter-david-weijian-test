import 'package:david_weijian_test/core/network/api_client.dart';
import 'package:david_weijian_test/data/repositories/route_repository_impl.dart';
import 'package:david_weijian_test/data/repositories/test_centre_repository_impl.dart';
import 'package:david_weijian_test/domain/repositories/route_repository.dart';
import 'package:david_weijian_test/domain/repositories/test_centre_repository.dart';
import 'package:david_weijian_test/presentation/controllers/content_controller.dart';
import 'package:get/get.dart';

class ContentBinding implements Bindings {
  @override
  void dependencies() {
    // Initialize ApiClient if not already done
    Get.lazyPut<ApiClient>(() => ApiClient(), fenix: true);
    
    // Initialize repositories
    Get.lazyPut<TestCentreRepository>(
      () => TestCentreRepositoryImpl(apiClient: Get.find<ApiClient>()),
      fenix: true,
    );
    
    Get.lazyPut<RouteRepository>(
      () => RouteRepositoryImpl(apiClient: Get.find<ApiClient>()),
      fenix: true,
    );
    
    // Initialize controller with dependencies
    Get.lazyPut<ContentController>(
      () => ContentController(
        testCentreRepo: Get.find<TestCentreRepository>(),
        routeRepo: Get.find<RouteRepository>(),
      ),
    );
  }
}