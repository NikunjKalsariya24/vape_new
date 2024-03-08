// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

CouponModel couponModelFromJson(String str) => CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  CouponData? data;

  CouponModel({
    this.data,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
    data: json["data"] == null ? null : CouponData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class CouponData {
  Coupons? coupons;

  CouponData({
    this.coupons,
  });

  factory CouponData.fromJson(Map<String, dynamic> json) => CouponData(
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
  dynamic description;
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
  String? shopId;
  dynamic userId;
  ImageDetails? image;

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
    this.image,
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
    image: json["image"] == null ? null : ImageDetails.fromJson(json["image"]),
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
    "image": image?.toJson(),
  };
}

class ImageDetails {
  String? thumbnail;
  String? original;
  String? id;

  ImageDetails({
    this.thumbnail,
    this.original,
    this.id,
  });

  factory ImageDetails.fromJson(Map<String, dynamic> json) => ImageDetails(
    thumbnail: json["thumbnail"],
    original: json["original"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "thumbnail": thumbnail,
    "original": original,
    "id": id,
  };
}
