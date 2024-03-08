// To parse this JSON data, do
//
//     final getCouponModel = getCouponModelFromJson(jsonString);

import 'dart:convert';

GetCouponModel getCouponModelFromJson(String str) => GetCouponModel.fromJson(json.decode(str));

String getCouponModelToJson(GetCouponModel data) => json.encode(data.toJson());

class GetCouponModel {
  GetCouponData? data;

  GetCouponModel({
    this.data,
  });

  factory GetCouponModel.fromJson(Map<String, dynamic> json) => GetCouponModel(
    data: json["data"] == null ? null : GetCouponData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class GetCouponData {
  Coupons? coupons;

  GetCouponData({
    this.coupons,
  });

  factory GetCouponData.fromJson(Map<String, dynamic> json) => GetCouponData(
    coupons: json["coupons"] == null ? null : Coupons.fromJson(json["coupons"]),
  );

  Map<String, dynamic> toJson() => {
    "coupons": coupons?.toJson(),
  };
}

class Coupons {
  List<Datum>? data;

  Coupons({
    this.data,
  });

  factory Coupons.fromJson(Map<String, dynamic> json) => Coupons(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? code;
  String? description;
  String? type;
  String? language;
  List<String>? translatedLanguages;
  bool? isValid;
  dynamic message;
  int? amount;
  int? minimumCartAmount;
  dynamic subTotal;
  DateTime? activeFrom;
  DateTime? expireAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? target;
  bool? isApprove;
  dynamic shopId;
  String? userId;

  Datum({
    this.id,
    this.code,
    this.description,
    this.type,
    this.language,
    this.translatedLanguages,
    this.isValid,
    this.message,
    this.amount,
    this.minimumCartAmount,
    this.subTotal,
    this.activeFrom,
    this.expireAt,
    this.createdAt,
    this.updatedAt,
    this.target,
    this.isApprove,
    this.shopId,
    this.userId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    code: json["code"],
    description: json["description"],
    type: json["type"],
    language: json["language"],
    translatedLanguages: json["translated_languages"] == null ? [] : List<String>.from(json["translated_languages"]!.map((x) => x)),
    isValid: json["is_valid"],
    message: json["message"],
    amount: json["amount"],
    minimumCartAmount: json["minimum_cart_amount"],
    subTotal: json["sub_total"],
    activeFrom: json["active_from"] == null ? null : DateTime.parse(json["active_from"]),
    expireAt: json["expire_at"] == null ? null : DateTime.parse(json["expire_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    target: json["target"],
    isApprove: json["is_approve"],
    shopId: json["shop_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "description": description,
    "type": type,
    "language": language,
    "translated_languages": translatedLanguages == null ? [] : List<dynamic>.from(translatedLanguages!.map((x) => x)),
    "is_valid": isValid,
    "message": message,
    "amount": amount,
    "minimum_cart_amount": minimumCartAmount,
    "sub_total": subTotal,
    "active_from": activeFrom?.toIso8601String(),
    "expire_at": expireAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "target": target,
    "is_approve": isApprove,
    "shop_id": shopId,
    "user_id": userId,
  };
}

