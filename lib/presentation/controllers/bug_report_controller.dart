// controller/bug_report_controller.dart
import 'package:david_weijian_test/data/models/user/bugreport_model.dart';
import 'package:david_weijian_test/domain/repositories/bug_report_repository.dart';
import 'package:get/get.dart';

class BugReportController extends GetxController {
  final BugReportRepository _repository;
  var isLoading = false.obs;
  var bugReports = <BugReport>[].obs;
  var errorMessage = ''.obs;

  BugReportController({required BugReportRepository repository}) 
      : _repository = repository;

  @override
  void onInit() {
    fetchBugReports();
    super.onInit();
  }

  Future<void> fetchBugReports() async {
    try {
      isLoading(true);
      errorMessage('');
      final reports = await _repository.fetchBugReports();
      bugReports.assignAll(reports);
    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar(
        'Error', 
        'Failed to fetch bug reports',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshReports() async {
    await fetchBugReports();
  }
}