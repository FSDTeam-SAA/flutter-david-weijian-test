// controller/user_controller.dart
import 'package:david_weijian_test/data/models/user/user_model.dart';
import 'package:david_weijian_test/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository _userRepository;
  var isLoading = false.obs;
  var users = <UserResponse>[].obs;
  var errorMessage = ''.obs;

  UserController({required UserRepository userRepository}) 
      : _userRepository = userRepository;

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading(true);
      errorMessage('');
      final fetchedUsers = await _userRepository.fetchUsers();
      debugPrint('Fetched users: $fetchedUsers');
      users.assignAll(fetchedUsers);
    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar('Error', 'Failed to fetch users: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  // Add additional methods as needed:
  Future<void> refreshData() async {
    await fetchUserData();
  }
}