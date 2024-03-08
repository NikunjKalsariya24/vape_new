// To parse this JSON data, do
//
//     final nearestStoreModel = nearestStoreModelFromJson(jsonString);

import 'dart:convert';

NearestStoreModel nearestStoreModelFromJson(String str) => NearestStoreModel.fromJson(json.decode(str));

String nearestStoreModelToJson(NearestStoreModel data) => json.encode(data.toJson());

class NearestStoreModel {
  NearestStoreData? data;

  NearestStoreModel({
    this.data,
  });

  factory NearestStoreModel.fromJson(Map<String, dynamic> json) => NearestStoreModel(
    data: json["data"] == null ? null : NearestStoreData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class NearestStoreData {
  Shop? shop;

  NearestStoreData({
    this.shop,
  });

  factory NearestStoreData.fromJson(Map<String, dynamic> json) => NearestStoreData(
    shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
  );

  Map<String, dynamic> toJson() => {
    "shop": shop?.toJson(),
  };
}

class Shop {
  String? id;
  String? ownerId;
  bool? isActive;
  int? ordersCount;
  int? productsCount;
  String? name;
  String? slug;
  String? description;
  dynamic distance;
  dynamic lat;
  dynamic lng;
  DateTime? createdAt;
  DateTime? updatedAt;

  Shop({
    this.id,
    this.ownerId,
    this.isActive,
    this.ordersCount,
    this.productsCount,
    this.name,
    this.slug,
    this.description,
    this.distance,
    this.lat,
    this.lng,
    this.createdAt,
    this.updatedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["id"],
    ownerId: json["owner_id"],
    isActive: json["is_active"],
    ordersCount: json["orders_count"],
    productsCount: json["products_count"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    distance: json["distance"],
    lat: json["lat"],
    lng: json["lng"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner_id": ownerId,
    "is_active": isActive,
    "orders_count": ordersCount,
    "products_count": productsCount,
    "name": name,
    "slug": slug,
    "description": description,
    "distance": distance,
    "lat": lat,
    "lng": lng,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
