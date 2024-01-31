class OrderRequestModel {
  final String orderName;
  final String buyerAddress;
  final String buyerMobile;
  final String buyerName;

  OrderRequestModel(
    this.orderName,
    this.buyerAddress,
    this.buyerMobile,
    this.buyerName,
  );
  Map<String, dynamic> getJson() {
    return {
      "orderName": orderName,
      "buyerAddress": buyerAddress,
      "buyerMobile": buyerMobile,
      "buyerName": buyerName,
    };
  }

  factory OrderRequestModel.getModelFromJson(Map<String, dynamic> json) {
    return OrderRequestModel(
      json["orderName"],
      json["buyerAddress"],
      json["buyerMobile"],
      json["buyerName"],
    );
  }
}
