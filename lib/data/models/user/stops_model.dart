class StopResponse {
  final String id;
  final double lat;
  final double lng;

  StopResponse({required this.id, required this.lat, required this.lng});

  factory StopResponse.fromJson(Map<String, dynamic> json) {
    return StopResponse(
      id: json['_id'],
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
    );
  }
}
