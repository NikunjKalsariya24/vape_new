class NonVariationProductModel {
  String? productId;
  dynamic productQuantity;
  String? productTitle;
  String? productUnit;
  String? productPrice;
  String? productImage;

  NonVariationProductModel(
      {this.productId,this.productQuantity,this.productTitle,this.productUnit, this.productPrice,this.productImage});

  factory NonVariationProductModel.fromJson(Map<String, dynamic> json) {
    return NonVariationProductModel(
        productId: json['productId'],
        productQuantity: json['productQuantity'],
        productTitle: json['productTitle'],
        productUnit: json['productUnit'],
        productPrice: json['productPrice'],
        productImage: json['productImage']);

  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productQuantity': productQuantity,
      'productTitle': productTitle,
      'productUnit': productUnit,
      'productPrice': productPrice,
      'productImage': productImage,

    };
  }
}
