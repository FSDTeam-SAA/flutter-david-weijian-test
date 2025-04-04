import 'package:david_weijian_test/presentation/controllers/content_controller.dart';
import 'package:david_weijian_test/presentation/screens/nav_itmes/nav_content/desktop_layout.dart';
import 'package:david_weijian_test/presentation/screens/nav_itmes/nav_content/mobile_layout.dart';
import 'package:david_weijian_test/presentation/screens/nav_itmes/nav_content/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class NavContentScreen extends StatelessWidget {
  final ContentController _controller = Get.find();

  NavContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: MobileLayout(controller: _controller),
        desktopBody: DesktopLayout(controller: _controller),
      ),
    );
  }
}