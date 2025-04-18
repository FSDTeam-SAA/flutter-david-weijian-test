class UserResponse {
  final String id;
  final String name;
  final String email;
  final DateTime dateOfBirth;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.dateOfBirth,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      role: json['who'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}