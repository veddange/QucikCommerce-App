class QuickSelectionCardModel {
  final String title;
  final String rating;
  final String quantity;
  final String discountPercentage;
  final String discountPrice;
  final String originalPrice;

  const QuickSelectionCardModel({
    required this.title,
    required this.rating,
    required this.quantity,
    required this.discountPercentage,
    required this.discountPrice,
    required this.originalPrice,
  });

  factory QuickSelectionCardModel.toJson(Map<String, dynamic> json) {
    return QuickSelectionCardModel(
      title: json['title'],
      rating: json['rating'],
      quantity: json['quantity'],
      discountPercentage: json['discountPercentage'],
      discountPrice: json['discountPrice'],
      originalPrice: json['originalPrice']
    );
  }
}
