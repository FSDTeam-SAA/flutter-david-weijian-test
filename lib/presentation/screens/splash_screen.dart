import 'package:david_weijian_test/presentation/controllers/splash_controller.dart';
import 'package:david_weijian_test/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(body: Column(children: [LoadingWidget()]));
  }
}
