// To parse this JSON data, do
//
//     final variationsProductModel = variationsProductModelFromJson(jsonString);

import 'dart:convert';

VariationsProductModel variationsProductModelFromJson(String str) => VariationsProductModel.fromJson(json.decode(str));

String variationsProductModelToJson(VariationsProductModel data) => json.encode(data.toJson());

class VariationsProductModel {
  VariationsData? data;

  VariationsProductModel({
    this.data,
  });

  factory VariationsProductModel.fromJson(Map<String, dynamic> json) => VariationsProductModel(
    data: json["data"] == null ? null : VariationsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class VariationsData {
  Product? product;

  VariationsData({
    this.product,
  });

  factory VariationsData.fromJson(Map<String, dynamic> json) => VariationsData(
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
  };
}

class Product {
  List<dynamic>? variations;

  Product({
    this.variations,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    variations: json["variations"] == null ? [] : List<dynamic>.from(json["variations"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "variations": variations == null ? [] : List<dynamic>.from(variations!.map((x) => x)),
  };
}
