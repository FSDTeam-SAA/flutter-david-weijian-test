import 'package:david_weijian_test/data/models/user/user_model.dart';

abstract class UserRepository {
  Future<List<UserResponse>> fetchUsers();
}