// product seller and buyer info

class ProductModel {
  final String url;
  final String productName;
  final double cost;
  final int discount;
  final String uid;
  final String sellerName;
  final String sellerUid;
  final int rating;
  final String description;

  ProductModel(
    this.url,
    this.productName,
    this.cost,
    this.discount,
    this.uid,
    this.sellerName,
    this.sellerUid,
    this.rating,
    this.description,
  );
  Map<String, dynamic> getJson() {
    return {
      "url": url,
      "productName": productName,
      "cost": cost,
      "discount": discount,
      "uid": uid,
      "sellerName": sellerName,
      "sellerUid": sellerUid,
      "rating": rating,
      "description": description,
    };
  }

  factory ProductModel.getModelFromJson(Map<String, dynamic> json) {
    return ProductModel(
      json["url"],
      json["productName"],
      json["cost"],
      json["discount"],
      json["uid"],
      json["sellerName"],
      json["sellerUid"],
      json["rating"],
      json["description"],
    );
  }
}
