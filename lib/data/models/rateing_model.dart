class RatingModel {
  final int totalRatings;
  final int rating1Count;
  final int rating2Count;
  final int rating3Count;
  final int rating4Count;
  final int rating5Count;

  RatingModel({
    required this.totalRatings,
    required this.rating1Count,
    required this.rating2Count,
    required this.rating3Count,
    required this.rating4Count,
    required this.rating5Count,
  });

  // Factory constructor for creating an instance from a Map
  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      totalRatings: map['total_ratings'] ?? 0,
      rating1Count: map['rating_1_count'] ?? 0,
      rating2Count: map['rating_2_count'] ?? 0,
      rating3Count: map['rating_3_count'] ?? 0,
      rating4Count: map['rating_4_count'] ?? 0,
      rating5Count: map['rating_5_count'] ?? 0,
    );
  }

  // Convert instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'totalRatings': totalRatings,
      'rating_1_count': rating1Count,
      'rating_2_count': rating2Count,
      'rating_3_count': rating3Count,
      'rating_4_count': rating4Count,
      'rating_5_count': rating5Count,
    };
  }

  // Create a copy of the instance with modified fields
  RatingModel copyWith({
    int? totalRatings,
    int? rating1Count,
    int? rating2Count,
    int? rating3Count,
    int? rating4Count,
    int? rating5Count,
  }) {
    return RatingModel(
      totalRatings: totalRatings ?? this.totalRatings,
      rating1Count: rating1Count ?? this.rating1Count,
      rating2Count: rating2Count ?? this.rating2Count,
      rating3Count: rating3Count ?? this.rating3Count,
      rating4Count: rating4Count ?? this.rating4Count,
      rating5Count: rating5Count ?? this.rating5Count,
    );
  }

  @override
  String toString() {
    return 'RatingModel(totalRatings: $totalRatings,'
        'rating1Count: $rating1Count, rating2Count: $rating2Count, '
        'rating3Count: $rating3Count, rating4Count: $rating4Count, '
        'rating5Count: $rating5Count)';
  }
}
