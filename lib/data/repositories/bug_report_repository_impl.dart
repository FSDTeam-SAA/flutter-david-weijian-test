import 'package:david_weijian_test/core/constants/api_constants.dart';
import 'package:david_weijian_test/core/network/api_client.dart';
import 'package:david_weijian_test/data/models/user/bugreport_model.dart';
import 'package:david_weijian_test/domain/repositories/bug_report_repository.dart';

class BugReportRepositoryImpl implements BugReportRepository {
  final ApiClient _apiClient;

  BugReportRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<BugReport>> fetchBugReports() async {
    final response = await _apiClient.get(ApiConstants.bugReportEndpoint);

    if (response.data is Map<String, dynamic> &&
        response.data.containsKey('data')) {
      final List<dynamic> reportsList =
          response.data['data']; // Extract the bug reports list

      return reportsList
          .map((reportJson) => BugReport.fromJson(reportJson))
          .toList();
    } else {
      throw Exception("Invalid API response format: Missing 'data' key");
    }
  }
}
