import 'package:david_weijian_test/core/constants/api_constants.dart';
import 'package:david_weijian_test/core/network/api_client.dart';
import 'package:david_weijian_test/data/models/user/test_centre_model.dart';
import 'package:david_weijian_test/domain/repositories/test_centre_repository.dart';
import 'package:flutter/material.dart';

class TestCentreRepositoryImpl implements TestCentreRepository {
  final ApiClient _apiClient;

  TestCentreRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<TestCentre>> fetchAllTestCentres() async {
    final response = await _apiClient.get(ApiConstants.testCentresEndpoint);

    debugPrint("Response: ${response.data}");

    if (response.data is! Map<String, dynamic> ||
        !response.data.containsKey('data')) {
      throw Exception("Invalid API response format");
    }

    if (response.data['status'] != true) {
      throw Exception(
        response.data['message'] ?? 'Failed to fetch test centres',
      );
    }

    try {
      return (response.data['data'] as List)
          .map((centre) => TestCentre.fromJson(centre))
          .toList();
    } catch (e) {
      debugPrint('Failed to parse test centres: $e');
      throw Exception('Failed to parse test centres: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> addTestCentre(Map<String, dynamic> data) async {
    final response = await _apiClient.post(
      ApiConstants.addTestCentreEndpoint,
      data,
    );

    if (response.data is! Map<String, dynamic>) {
      throw Exception("Invalid API response format");
    }

    if (response.data['status'] != true) {
      throw Exception(response.data['message'] ?? 'Failed to add test centre');
    }

    return response.data;
  }

  @override
  Future<Map<String, dynamic>> updateTestCentre(
    String id,
    Map<String, dynamic> data,
  ) async {
    final response = await _apiClient.put(
      '${ApiConstants.updateTestCentreEndpoint}/$id',
      data,
    );

    if (response.data is! Map<String, dynamic>) {
      throw Exception("Invalid API response format");
    }

    if (response.data['status'] != true) {
      throw Exception(
        response.data['message'] ?? 'Failed to update test centre',
      );
    }

    return response.data;
  }

  @override
  Future<Map<String, dynamic>> deleteTestCentre(String id) async {
    final response = await _apiClient.delete(
      '${ApiConstants.deleteTestCentreEndpoint}/$id',
    );

    if (response.data is! Map<String, dynamic>) {
      throw Exception("Invalid API response format");
    }

    if (response.data['status'] != true) {
      throw Exception(
        response.data['message'] ?? 'Failed to delete test centre',
      );
    }

    return response.data;
  }
}
