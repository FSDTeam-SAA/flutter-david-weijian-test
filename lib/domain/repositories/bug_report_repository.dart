// domain/repositories/bug_report_repository.dart
import 'package:david_weijian_test/data/models/user/bugreport_model.dart';

abstract class BugReportRepository {
  Future<List<BugReport>> fetchBugReports();
}