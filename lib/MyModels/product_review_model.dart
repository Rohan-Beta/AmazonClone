class ProductReviewModel {
  final String senderName;
  final String description;
  final int rating;

  ProductReviewModel(
      {required this.senderName,
      required this.description,
      required this.rating});

  Map<String, dynamic> getJson() {
    return {
      "senderName": senderName,
      "description": description,
      "rating": rating,
    };
  }

  factory ProductReviewModel.getModelFromJson(Map<String, dynamic> json) {
    return ProductReviewModel(
      senderName: json["senderName"],
      description: json["description"],
      rating: json["rating"],
    );
  }
}
