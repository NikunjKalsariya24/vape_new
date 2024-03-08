// To parse this JSON data, do
//
//     final toggleWishListModel = toggleWishListModelFromJson(jsonString);

import 'dart:convert';

ToggleWishListModel toggleWishListModelFromJson(String str) => ToggleWishListModel.fromJson(json.decode(str));

String toggleWishListModelToJson(ToggleWishListModel data) => json.encode(data.toJson());

class ToggleWishListModel {
  ToggleWishData? data;

  ToggleWishListModel({
    this.data,
  });

  factory ToggleWishListModel.fromJson(Map<String, dynamic> json) => ToggleWishListModel(
    data: json["data"] == null ? null : ToggleWishData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class ToggleWishData {
  bool? toggleWishlist;

  ToggleWishData({
    this.toggleWishlist,
  });

  factory ToggleWishData.fromJson(Map<String, dynamic> json) => ToggleWishData(
    toggleWishlist: json["toggleWishlist"],
  );

  Map<String, dynamic> toJson() => {
    "toggleWishlist": toggleWishlist,
  };
}
