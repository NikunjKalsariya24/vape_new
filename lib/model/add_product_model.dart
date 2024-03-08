// To parse this JSON data, do
//
//     final addProductModel = addProductModelFromJson(jsonString);

import 'dart:convert';

AddProductModel addProductModelFromJson(String str) => AddProductModel.fromJson(json.decode(str));

String addProductModelToJson(AddProductModel data) => json.encode(data.toJson());

class AddProductModel {
  AddProductData? data;

  AddProductModel({
    this.data,
  });

  factory AddProductModel.fromJson(Map<String, dynamic> json) => AddProductModel(
    data: json["data"] == null ? null : AddProductData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class AddProductData {
  String? addtocartProduct;

  AddProductData({
    this.addtocartProduct,
  });

  factory AddProductData.fromJson(Map<String, dynamic> json) => AddProductData(
    addtocartProduct: json["AddtocartProduct"],
  );

  Map<String, dynamic> toJson() => {
    "AddtocartProduct": addtocartProduct,
  };
}
