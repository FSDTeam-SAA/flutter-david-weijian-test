// Controller to manage sidebar state
import 'package:david_weijian_test/core/routes/app_routes.dart';
import 'package:get/get.dart';

class SidebarController extends GetxController {
  final RxString currentSection = Routes.users.obs;
  final RxBool isSidebarVisible = true.obs;

  void toggleSidebar() => isSidebarVisible.toggle();
  void showSection(String section) => currentSection.value = section;
}
