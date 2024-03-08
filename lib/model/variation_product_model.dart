class VariationProductModel {
  String? productId;
  dynamic productQuantity;
  String? productTitle;
  String? productUnit;
  String? productVariation;
  String? productVariationId;
  String? productPrice;
  String? productImage;

  VariationProductModel(
      {this.productId,this.productQuantity,this.productTitle,this.productUnit, this.productPrice,this.productImage,this.productVariation,this.productVariationId});

  factory VariationProductModel.fromJson(Map<String, dynamic> json) {
    return VariationProductModel(
        productId: json['productId'],
        productQuantity: json['productQuantity'],
        productTitle: json['productTitle'],
        productUnit: json['productUnit'],
        productVariation: json['productVariation'],
        productVariationId: json['productVariationId'],
        productPrice: json['productPrice'],
        productImage: json['productImage']);

  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productQuantity': productQuantity,
      'productTitle': productTitle,
      'productUnit': productUnit,
      'productVariation': productVariation,
      'productVariationId': productVariationId,
      'productPrice': productPrice,
      'productImage': productImage,

    };
  }
}
