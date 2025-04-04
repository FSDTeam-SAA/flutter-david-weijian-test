

class ContactResponse {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String description;

  ContactResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.description,
  });

  factory ContactResponse.fromJson(Map<String, dynamic> json) {
    return ContactResponse(
      id: json['_id'],
      name: json['name'] ?? 'No Name',
      email: json['email'] ?? 'No Email',
      phone: json['phone'] ?? 'No Phone',
      description: json['description'] ?? '',
    );
  }
}
