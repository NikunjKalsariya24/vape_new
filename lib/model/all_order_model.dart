// To parse this JSON data, do
//
//     final allOrderModel = allOrderModelFromJson(jsonString);

import 'dart:convert';

AllOrderModel allOrderModelFromJson(String str) => AllOrderModel.fromJson(json.decode(str));

String allOrderModelToJson(AllOrderModel data) => json.encode(data.toJson());

class AllOrderModel {
  AllOrderData? data;

  AllOrderModel({
    this.data,
  });

  factory AllOrderModel.fromJson(Map<String, dynamic> json) => AllOrderModel(
    data: json["data"] == null ? null : AllOrderData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class AllOrderData {
  Orders? orders;

  AllOrderData({
    this.orders,
  });

  factory AllOrderData.fromJson(Map<String, dynamic> json) => AllOrderData(
    orders: json["orders"] == null ? null : Orders.fromJson(json["orders"]),
  );

  Map<String, dynamic> toJson() => {
    "orders": orders?.toJson(),
  };
}

class Orders {
  List<dynamic>? data;

  Orders({
    this.data,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
