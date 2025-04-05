import 'package:david_weijian_test/presentation/controllers/navbar_controller.dart';
import 'package:david_weijian_test/presentation/screens/drawer/drawer.dart';
import 'package:david_weijian_test/presentation/screens/nav_itmes/bug_report_nav_screen.dart';
import 'package:david_weijian_test/presentation/screens/nav_itmes/nav_content/nav_content_screen.dart';
import 'package:david_weijian_test/presentation/screens/nav_itmes/user_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:david_weijian_test/core/routes/app_routes.dart';


class DashboardScreen extends StatelessWidget {
   final Widget child;
  
  const DashboardScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App Name'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Get.find<SidebarController>().toggleSidebar();
          },
        ),
      ),
      body: Row(
        children: [
          // Persistent Sidebar
          Obx(() {
            final isVisible = Get.find<SidebarController>().isSidebarVisible.value;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isVisible ? 250 : 0,
              child: isVisible ? const AppDrawer() : null,
            );
          }),
          // Main Content
          Expanded(
            child: Obx(() {
              final currentSection = Get.find<SidebarController>().currentSection.value;
              return _getContentForSection(currentSection);
            }),
          ),
        ],
      ),
    );
  }

  Widget _getContentForSection(String section) {
    switch (section) {
      case Routes.users:
        return  UserScreen();
      case Routes.bugReport:
        return BugReportScreen();
      case Routes.content:
        return NavContentScreen();
      case Routes.subscription:
        // return const SubscriptionScreen();
      case Routes.package:
        // return const PackageScreen();
      case Routes.featureAccess:
        // return const FeatureAccessScreen();
      case Routes.reportAnalytics:
        // return const ReportAnalyticsScreen();
      case Routes.marketing:
        // return const MarketingScreen();
      case Routes.support:
        // return const SupportScreen();
      case Routes.compliance:
        // return const ComplianceScreen();
      case Routes.settings:
        // return const SettingsScreen();
      default:
        return const Center(child: Text('Section not found'));
    }
  }
}
