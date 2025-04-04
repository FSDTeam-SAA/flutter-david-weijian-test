import 'package:david_weijian_test/core/network/api_client.dart';
import 'package:david_weijian_test/core/routes/app_pages.dart';
import 'package:david_weijian_test/core/routes/app_routes.dart';
import 'package:david_weijian_test/presentation/bindings/app_binding.dart';
import 'package:david_weijian_test/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient.init(); // Attach interceptors early
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppThemes.appThemeData,
      initialBinding: AppBindings(),
      initialRoute: Routes.splash,
      getPages: AppPages.routes,
    );
  }
}
