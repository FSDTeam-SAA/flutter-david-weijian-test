import 'package:david_weijian_test/data/models/user/route_model.dart';

abstract class RouteRepository {
  Future<RouteResponse> getAllRoutes(String testCentreId);
  Future<Map<String, dynamic>> createRoute(Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateRoute(String id, Map<String, dynamic> data);
  Future<Map<String, dynamic>> deleteRoute(String id);
}