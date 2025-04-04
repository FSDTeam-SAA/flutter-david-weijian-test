class BugReportResponse {
  final String id;
  final String project;
  final String screenName;
  final String message;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  BugReportResponse({
    required this.id,
    required this.project,
    required this.screenName,
    required this.message,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BugReportResponse.fromJson(Map<String, dynamic> json) {
    return BugReportResponse(
      id: json['_id'],
      project: json['project'],
      screenName: json['screenName'],
      message: json['message'],
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
