import 'package:david_weijian_test/data/models/user/route_model.dart';
import 'package:david_weijian_test/data/models/user/test_centre_model.dart';
import 'package:david_weijian_test/domain/repositories/route_repository.dart';
import 'package:david_weijian_test/domain/repositories/test_centre_repository.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:math';

class ContentController extends GetxController {
  // Repositories
  final TestCentreRepository _testCentreRepo;
  final RouteRepository _routeRepo;

  // Reactive variables
  var testCentreName = ''.obs;
  var passRate = '0'.obs;
  var routes = 0.obs;
  var testCentreAddress = ''.obs;
  var postCode = ''.obs;
  var testCentreId = ''.obs;
  var routeId = ''.obs;
  var routeName = ''.obs;
  var shareUrl = ''.obs;
  var address = ''.obs;
  var fileName = ''.obs;
  var from = ''.obs;
  var to = ''.obs;
  var expectedTime = 0.obs;
  var listOfStops = <Map<String, dynamic>>[].obs;
  var showAddTestCentre = true.obs;
  var selectedTestCentre = <String, dynamic>{}.obs;
  var routeResponse = Rx<RouteResponse?>(null);
  var isLoading = false.obs;
  var showAddTestCentreButton = false.obs;
  var showRouteDetails = false.obs;
  var isEditing = false.obs;
  var testCentres = <TestCentre>[].obs;
  var addNewRoute = false.obs;

  ContentController({
    required TestCentreRepository testCentreRepo,
    required RouteRepository routeRepo,
  })  : _testCentreRepo = testCentreRepo,
        _routeRepo = routeRepo;

  @override
  void onInit() {
    fetchAllTestCentres();
    super.onInit();
  }

  // Test Centre Methods
  Future<void> fetchAllTestCentres() async {
    isLoading(true);
    try {
      final centres = await _testCentreRepo.fetchAllTestCentres();
      testCentres.assignAll(centres);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> addTestCentre() async {
    isLoading(true);
    final data = {
      "name": testCentreName.value,
      "passRate": passRate.value,
      "routes": routes.value,
      "address": testCentreAddress.value,
      "postCode": postCode.value,
    };

    try {
      final response = await _testCentreRepo.addTestCentre(data);
      if (response['status'] == true) {
        testCentreId.value = response['data']['_id'];
        testCentreName.value = response['data']['name'];
        showAddTestCentre.value = false;
        Get.snackbar('Success', 'Test Centre added successfully');
        await fetchAllTestCentres();
      } else {
        Get.snackbar('Error', response['message'] ?? 'Failed to add test centre');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add test centre: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateTestCentre() async {
    isLoading(true);
    final data = {
      "name": testCentreName.value,
      "address": testCentreAddress.value,
      "postCode": postCode.value,
      "passRate": passRate.value,
      "routes": routes.value,
    };

    try {
      final response = await _testCentreRepo.updateTestCentre(testCentreId.value, data);
      if (response['status'] == true) {
        Get.snackbar('Success', 'Test Centre updated successfully');
        await fetchAllTestCentres();
        resetTestCentreForm();
      } else {
        throw Exception(response['message'] ?? 'Failed to update test centre');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update test centre: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteTestCentre(String id) async {
    isLoading(true);
    try {
      final response = await _testCentreRepo.deleteTestCentre(id);
      if (response['status'] == true) {
        Get.snackbar('Success', 'Test Centre deleted successfully');
        await fetchAllTestCentres();
        resetTestCentreForm();
      } else {
        throw Exception(response['message'] ?? 'Failed to delete test centre');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete test centre: $e');
    } finally {
      isLoading(false);
    }
  }

  // Route Methods
  Future<void> getAllRoutes(String id) async {
    isLoading(true);
    try {
      testCentreId.value = id;
      final response = await _routeRepo.getAllRoutes(id);
      routeResponse.value = response;
      showRouteDetails.value = true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> createRoute() async {
    isLoading(true);
    final data = {
      "testCentreId": testCentreId.value,
      "routeName": routeName.value,
      "TestCentreName": testCentreName.value,
      "expectedTime": expectedTime.value,
      "shareUrl": shareUrl.value,
      "listOfStops": listOfStops.toList(),
      "startCoordinator": {
        "lat": listOfStops.first['lat'],
        "lng": listOfStops.first['lng'],
      },
      "endCoordinator": {
        "lat": listOfStops.last['lat'],
        "lng": listOfStops.last['lng'],
      },
      "isUser": "admin",
      "from": from.value,
      "to": to.value,
      "passRate": double.tryParse(passRate.value) ?? 0.0,
      "address": address.value,
      "view": 0,
      "favorite": [],
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    };

    try {
      await _routeRepo.createRoute(data);
      Get.snackbar('Success', 'Route created successfully');
      clearRouteForm();
      showRouteDetails.value = false;
      showAddTestCentreButton.value = false;
      await fetchAllTestCentres();
    } catch (e) {
      Get.snackbar('Error', 'Failed to create route: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateRoute() async {
    try {
      isLoading(true);
      final data = {
        "routeName": routeName.value,
        "shareUrl": shareUrl.value,
        "address": address.value,
        "from": from.value,
        "to": to.value,
        "expectedTime": expectedTime.value,
        "listOfStops": listOfStops.toList(),
        "startCoordinator": {
          "lat": listOfStops.first['lat'],
          "lng": listOfStops.first['lng'],
        },
        "endCoordinator": {
          "lat": listOfStops.last['lat'],
          "lng": listOfStops.last['lng'],
        },
      };

      final response = await _routeRepo.updateRoute(routeId.value, data);
      if (response['status'] == true) {
        Get.snackbar('Success', 'Route updated successfully');
        isEditing.value = false;
        resetRouteForm();
        await getAllRoutes(testCentreId.value);
      } else {
        throw Exception(response['message'] ?? 'Failed to update route');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update route: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteRoute(String routeId) async {
    try {
      isLoading(true);
      final response = await _routeRepo.deleteRoute(routeId);
      if (response['status'] == true) {
        Get.snackbar('Success', 'Route deleted successfully');
        if (testCentreId.value.isNotEmpty) {
          await getAllRoutes(testCentreId.value);
        }
        await fetchAllTestCentres();
      } else {
        throw Exception(response['message'] ?? 'Failed to delete route');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete route: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  // Helper Methods (keep all your existing helper methods)
  void resetTestCentreForm() {
    testCentreId.value = '';
    testCentreName.value = '';
    testCentreAddress.value = '';
    postCode.value = '';
    showAddTestCentreButton.value = true;
  }

  void resetRouteForm() {
    routeId.value = '';
    routeName.value = '';
    shareUrl.value = '';
    address.value = '';
    from.value = '';
    to.value = '';
    expectedTime.value = 0;
    listOfStops.value = [];
    fileName.value = '';
    isEditing.value = false;
  }

  void clearRouteForm() {
    routeName.value = '';
    shareUrl.value = '';
    address.value = '';
    fileName.value = '';
    from.value = '';
    to.value = '';
    expectedTime.value = 0;
    listOfStops.value = [];
  }

  void setSelectedTestCentre(Map<String, dynamic> testCentre) {
    selectedTestCentre.value = testCentre;
  }

  void setSelectedRouteForEditing(RouteModel route) {
    testCentreId.value = "";
    routeId.value = route.id;
    routeName.value = route.routeName;
    shareUrl.value = route.shareUrl;
    address.value = route.address;
    from.value = route.from;
    to.value = route.to;
    expectedTime.value = route.expectedTime;
    listOfStops.value = route.listOfStops.map((stop) {
      return {
        'lat': stop.lat,
        'lng': stop.lng,
      };
    }).toList();
    showAddTestCentreButton.value = true;
    isEditing.value = true;
  }

  void setTestCentreForEditing(TestCentre testCentre) {
    testCentreId.value = testCentre.id;
    testCentreName.value = testCentre.name;
    testCentreAddress.value = testCentre.address;
    postCode.value = testCentre.postCode;
    passRate.value = testCentre.passRate.toString();
    routes.value = testCentre.routes;
    isEditing.value = true;
    showAddTestCentreButton.value = true;
    showRouteDetails.value = false;
    showAddTestCentre.value = true;
  }

  void cancelEditTestCentre() {
    resetTestCentreForm();
    isEditing.value = false;
  }

  // File handling methods (keep all your existing file handling methods)
  Future<void> pickAndParseGPXFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['gpx'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        fileName.value = file.name;
        String fileContent = await _readFileContentWeb(file);
        List<Map<String, dynamic>> locations = _parseGPXFile(fileContent);
        listOfStops.value = locations;
        double totalDistance = _calculateTotalDistance(locations);
        int calculatedTime = _calculateExpectedTime(totalDistance);
        expectedTime.value = calculatedTime;
        _fillDataFromGPX(fileContent);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick or parse file: $e');
    }
  }

  // ... (keep all your existing private helper methods)
  Future<String> _readFileContentWeb(PlatformFile file) async {
    return String.fromCharCodes(file.bytes!);
  }

  List<Map<String, dynamic>> _parseGPXFile(String fileContent) {
    try {
      final document = xml.XmlDocument.parse(fileContent);
      final waypoints = document.findAllElements('wpt').toList();
      final routePoints = document.findAllElements('rtept').toList();
      final allPoints = [...waypoints, ...routePoints];

      return allPoints.where((point) {
        return point.getAttribute('lat') != null && point.getAttribute('lon') != null;
      }).map((point) {
        return {
          'lat': double.parse(point.getAttribute('lat')!),
          'lng': double.parse(point.getAttribute('lon')!),
          'ele': point.findElements('ele').singleOrNull?.innerText,
          'name': point.findElements('name').singleOrNull?.innerText,
          'desc': point.findElements('desc').singleOrNull?.innerText,
        };
      }).toList();
    } catch (e) {
      throw Exception('Error parsing GPX file: $e');
    }
  }

  double _calculateTotalDistance(List<Map<String, dynamic>> locations) {
    double totalDistance = 0;
    for (int i = 0; i < locations.length - 1; i++) {
      totalDistance += haversineDistance(
        locations[i]['lat'],
        locations[i]['lng'],
        locations[i + 1]['lat'],
        locations[i + 1]['lng'],
      );
    }
    return totalDistance;
  }

  int _calculateExpectedTime(double totalDistance) {
    const double averageSpeed = 50;
    double timeInHours = totalDistance / averageSpeed;
    return (timeInHours * 60).round();
  }

  void _fillDataFromGPX(String fileContent) {
    try {
      final document = xml.XmlDocument.parse(fileContent);
      final waypoints = document.findAllElements('wpt').toList();
      if (waypoints.isNotEmpty) {
        from.value = waypoints.first.findElements('name').firstOrNull?.innerText ?? 'Start';
        to.value = waypoints.last.findElements('name').firstOrNull?.innerText ?? 'End';
      }
    } catch (e) {
      throw Exception('Error filling data from GPX file: $e');
    }
  }

  double haversineDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371;
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    double a = pow(sin(dLat / 2), 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * (pi / 180);
  }
}