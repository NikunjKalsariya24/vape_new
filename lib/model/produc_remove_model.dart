// To parse this JSON data, do
//
//     final productRemoveModel = productRemoveModelFromJson(jsonString);

import 'dart:convert';

ProductRemoveModel productRemoveModelFromJson(String str) => ProductRemoveModel.fromJson(json.decode(str));

String productRemoveModelToJson(ProductRemoveModel data) => json.encode(data.toJson());

class ProductRemoveModel {
  ProductRemoveData? data;

  ProductRemoveModel({
    this.data,
  });

  factory ProductRemoveModel.fromJson(Map<String, dynamic> json) => ProductRemoveModel(
    data: json["data"] == null ? null : ProductRemoveData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class ProductRemoveData {
  String? addtocartProductRemove;

  ProductRemoveData({
    this.addtocartProductRemove,
  });

  factory ProductRemoveData.fromJson(Map<String, dynamic> json) => ProductRemoveData(
    addtocartProductRemove: json["AddtocartProductRemove"],
  );

  Map<String, dynamic> toJson() => {
    "AddtocartProductRemove": addtocartProductRemove,
  };
}
