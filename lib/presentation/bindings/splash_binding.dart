import 'package:david_weijian_test/presentation/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    debugPrint("Initializing SplashBinding");
    Get.lazyPut<SplashController>(() => SplashController());
  }
}