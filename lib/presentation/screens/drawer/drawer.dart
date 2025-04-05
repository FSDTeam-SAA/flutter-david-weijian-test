import 'package:david_weijian_test/core/routes/app_routes.dart';
import 'package:david_weijian_test/presentation/controllers/navbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: const Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          _createSidebarItem(
            icon: Icons.people,
            text: 'Users',
            section: Routes.users,
          ),
          _createSidebarItem(
            icon: Icons.bug_report,
            text: 'Bug Report',
            section: Routes.bugReport,
          ),
          _createSidebarItem(
            icon: Icons.content_paste,
            text: 'Content',
            section: Routes.content,
          ),
          _createSidebarItem(
            icon: Icons.subscriptions,
            text: 'Subscription',
            section: Routes.subscription,
          ),
          _createSidebarItem(
            icon: Icons.inventory,
            text: 'Package',
            section: Routes.package,
          ),
          _createSidebarItem(
            icon: Icons.lock_open,
            text: 'Feature Access',
            section: Routes.featureAccess,
          ),
          _createSidebarItem(
            icon: Icons.analytics,
            text: 'Report Analytics',
            section: Routes.reportAnalytics,
          ),
          _createSidebarItem(
            icon: Icons.mark_email_read,
            text: 'Marketing',
            section: Routes.marketing,
          ),
          _createSidebarItem(
            icon: Icons.support_agent,
            text: 'Support',
            section: Routes.support,
          ),
          _createSidebarItem(
            icon: Icons.security,
            text: 'Compliance',
            section: Routes.compliance,
          ),
          const Divider(),
          _createSidebarItem(
            icon: Icons.settings,
            text: 'Settings',
            section: Routes.settings,
          ),
        ],
      ),
    );
  }

  Widget _createSidebarItem({
    required IconData icon,
    required String text,
    required String section,
  }) {
    return Obx(() {
      final currentSection = Get.find<SidebarController>().currentSection.value;
      final isActive = currentSection == section;

      return ListTile(
        leading: Icon(icon, color: isActive ? Colors.blue : null),
        title: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.blue : null,
            fontWeight: isActive ? FontWeight.bold : null,
          ),
        ),
        selected: isActive,
        onTap: () => Get.find<SidebarController>().showSection(section),
      );
    });
  }
}
