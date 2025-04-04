import 'package:david_weijian_test/core/routes/app_routes.dart';
import 'package:david_weijian_test/domain/repositories/user_repository.dart';
import 'package:david_weijian_test/presentation/bindings/auth_binding.dart';
import 'package:david_weijian_test/presentation/bindings/splash_binding.dart';
import 'package:david_weijian_test/presentation/controllers/user_controller.dart';
import 'package:david_weijian_test/presentation/screens/auth/login_screen.dart';
import 'package:david_weijian_test/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:david_weijian_test/presentation/screens/nav_itmes/user_nav_screen.dart';
import 'package:david_weijian_test/presentation/screens/splash_screen.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardScreen(),
      // bindings: [
      //   DashboardBinding(),
      //   UserBinding(),
      // ],
      // middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.users,
      page: () => UserScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<UserController>(
          () => UserController(userRepository: Get.find<UserRepository>()),
        );
      }),
    ),
  ];
}
