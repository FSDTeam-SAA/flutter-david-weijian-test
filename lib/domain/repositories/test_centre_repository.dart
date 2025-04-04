import 'package:david_weijian_test/data/models/user/test_centre_model.dart';

abstract class TestCentreRepository {
  Future<List<TestCentre>> fetchAllTestCentres();
  Future<Map<String, dynamic>> addTestCentre(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateTestCentre(String id, Map<String, dynamic> data);
  Future<Map<String, dynamic>> deleteTestCentre(String id);
}