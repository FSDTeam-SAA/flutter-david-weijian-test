class ReviewDataResponse {
  final String id;
  final String routeName;
  final String testCentreName;
  final String address;
  final List<Review> reviews;

  ReviewDataResponse({
    required this.id,
    required this.routeName,
    required this.testCentreName,
    required this.address,
    required this.reviews,
  });

  factory ReviewDataResponse.fromJson(Map<String, dynamic> json) {
    return ReviewDataResponse(
      id: json["_id"],
      routeName: json["routeName"],
      testCentreName: json["TestCentreName"] ?? "",
      address: json["address"],
      reviews: (json["reviews"] as List)
          .map((review) => Review.fromJson(review))
          .toList(),
    );
  }
}

class Review {
  final int rating;
  final String reviewMessage;
  final UserId user;
  final String id;

  Review({
    required this.rating,
    required this.reviewMessage,
    required this.user,
    required this.id,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json["rating"],
      reviewMessage: json["reviewMessage"],
      user: UserId.fromJson(json["userId"]),
      id: json["_id"],
    );
  }
}

class UserId {
  final String name;
  final String email;

  UserId({
    required this.name,
    required this.email,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      name: json["name"],
      email: json["email"],
    );
  }
}
