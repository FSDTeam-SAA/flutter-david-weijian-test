// presentation/screens/user_screen.dart
import 'package:david_weijian_test/data/models/user/user_model.dart';
import 'package:david_weijian_test/presentation/controllers/user_controller.dart';
import 'package:david_weijian_test/presentation/widgets/user_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserScreen extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: userController.refreshData,
          ),
        ],
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (userController.errorMessage.value.isNotEmpty) {
          return Center(child: Text(userController.errorMessage.value));
        }

        return _buildUserTable();
      }),
    );
  }

  Widget _buildUserTable() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Role')),
              DataColumn(label: Text('DOB')),
              DataColumn(label: Text('Actions')),
            ],
            rows: userController.users.map((user) => DataRow(
              cells: [
                DataCell(Text(user.id.substring(0, 8))),
                DataCell(Text(user.name)),
                DataCell(Text(user.email)),
                DataCell(
                  Chip(
                    label: Text(user.role.toUpperCase()),
                    backgroundColor: _getRoleColor(user.role),
                  ),
                ),
                DataCell(Text(_formatDate(user.dateOfBirth))),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () => _showUserDetails(user),
                  ),
                ),
              ],
            )).toList(),
          ),
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin': return Colors.blueAccent;
      case 'user': return Colors.green;
      default: return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showUserDetails(UserResponse user) {
    Get.dialog(
      UserDetailDialog(user: user),
    );
  }
}