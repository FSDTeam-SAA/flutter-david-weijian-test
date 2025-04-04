import 'package:david_weijian_test/core/constants/api_constants.dart';
import 'package:david_weijian_test/core/network/api_client.dart';
import 'package:david_weijian_test/data/models/user/route_model.dart';
import 'package:david_weijian_test/domain/repositories/route_repository.dart';
import 'package:flutter/widgets.dart';

class RouteRepositoryImpl implements RouteRepository {
  final ApiClient _apiClient;

  RouteRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<RouteResponse> getAllRoutes(String testCentreId) async {
    final response = await _apiClient.get(
      '${ApiConstants.routesEndpoint}/$testCentreId',
    );

    debugPrint("Response: ${response.data}");

    if (response.data is! Map<String, dynamic> ||
        !response.data.containsKey('data')) {
      throw Exception("Invalid API response format");
    }

    try {
      return RouteResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to parse routes: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> createRoute(Map<String, dynamic> data) async {
    final response = await _apiClient.post(
      ApiConstants.createRouteEndpoint,
      data,
    );

    if (response.data is! Map<String, dynamic>) {
      throw Exception("Invalid API response format");
    }

    if (response.data['status'] != true) {
      throw Exception(response.data['message'] ?? 'Failed to create route');
    }

    return response.data;
  }

  @override
  Future<Map<String, dynamic>> updateRoute(
    String routeId,
    Map<String, dynamic> data,
  ) async {
    final response = await _apiClient.put(
      '${ApiConstants.updateRouteEndpoint}/$routeId',
      data,
    );

    if (response.data is! Map<String, dynamic>) {
      throw Exception("Invalid API response format");
    }

    if (response.data['status'] != true) {
      throw Exception(response.data['message'] ?? 'Failed to update route');
    }

    return response.data;
  }

  @override
  Future<Map<String, dynamic>> deleteRoute(String routeId) async {
    final response = await _apiClient.delete(
      '${ApiConstants.deleteRouteEndpoint}/$routeId',
    );

    if (response.data is! Map<String, dynamic>) {
      throw Exception("Invalid API response format");
    }

    if (response.data['status'] != true) {
      throw Exception(response.data['message'] ?? 'Failed to delete route');
    }

    return response.data;
  }
}
