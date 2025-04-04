class TestCentre {
  final String id;
  final String name;
  final String passRate;
  final int routes;
  final String address;
  final String postCode;
  final DateTime createdAt;
  final DateTime updatedAt;

  TestCentre({
    required this.id,
    required this.name,
    required this.passRate,
    required this.routes,
    required this.address,
    required this.postCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TestCentre.fromJson(Map<String, dynamic> json) {
    return TestCentre(
      id: json['_id'] ?? '', 
      name: json['name'] ?? '', 
      passRate: json['passRate']?.toString() ?? '0', // Convert int to String
      routes: json['routes'] ?? 0, 
      address: json['address'] ?? '', 
      postCode: json['postCode'] ?? '', 
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(), // Handle null safely
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : DateTime.now(), // Handle null safely
    );
  }
}
