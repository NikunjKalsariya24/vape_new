// To parse this JSON data, do
//
//     final inWishListModel = inWishListModelFromJson(jsonString);

import 'dart:convert';

InWishListModel inWishListModelFromJson(String str) => InWishListModel.fromJson(json.decode(str));

String inWishListModelToJson(InWishListModel data) => json.encode(data.toJson());

class InWishListModel {
  InWishListData? data;

  InWishListModel({
    this.data,
  });

  factory InWishListModel.fromJson(Map<String, dynamic> json) => InWishListModel(
    data: json["data"] == null ? null : InWishListData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class InWishListData {
  bool? inWishlist;

  InWishListData({
    this.inWishlist,
  });

  factory InWishListData.fromJson(Map<String, dynamic> json) => InWishListData(
    inWishlist: json["in_wishlist"],
  );

  Map<String, dynamic> toJson() => {
    "in_wishlist": inWishlist,
  };
}
