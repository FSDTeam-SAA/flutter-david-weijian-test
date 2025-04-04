// presentation/widgets/user_detail_dialog.dart
import 'package:david_weijian_test/data/models/user/user_model.dart';
import 'package:flutter/material.dart';

class UserDetailDialog extends StatelessWidget {
  final UserResponse user;

  const UserDetailDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('User Details: ${user.name}'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('ID:', user.id),
            _buildDetailRow('Name:', user.name),
            _buildDetailRow('Email:', user.email),
            _buildDetailRow('Role:', user.role),
            _buildDetailRow('Date of Birth:', 
                '${user.dateOfBirth.day}/${user.dateOfBirth.month}/${user.dateOfBirth.year}'),
            _buildDetailRow('Created At:', 
                user.createdAt.toString().substring(0, 19)),
            _buildDetailRow('Updated At:', 
                user.updatedAt.toString().substring(0, 19)),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Flexible(child: Text(value)),
        ],
      ),
    );
  }
}