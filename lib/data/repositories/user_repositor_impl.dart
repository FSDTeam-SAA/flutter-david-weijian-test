import 'package:david_weijian_test/core/constants/api_constants.dart';
import 'package:david_weijian_test/core/network/api_client.dart';
import 'package:david_weijian_test/data/models/user/user_model.dart';
import 'package:david_weijian_test/domain/repositories/user_repository.dart';
import 'package:flutter/widgets.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiClient apiClient;

  UserRepositoryImpl({required this.apiClient});

  @override
  Future<List<UserResponse>> fetchUsers() async {
    final response = await apiClient.get(ApiConstants.usersEndpoint);

    debugPrint('Response: ${response.data}');

    // Ensure response is a Map and contains "data" key
    if (response.data is Map<String, dynamic> &&
        response.data.containsKey('data')) {
      final List<dynamic> usersList =
          response.data['data']; // Extract the user list

      return usersList
          .map((userJson) => UserResponse.fromJson(userJson))
          .where((user) => user.role == "user")
          .toList();
    } else {
      throw Exception("Invalid API response format: Missing 'data' key");
    }
  }
}
