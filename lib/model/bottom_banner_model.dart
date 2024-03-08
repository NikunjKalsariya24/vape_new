// To parse this JSON data, do
//
//     final bottomBannerModel = bottomBannerModelFromJson(jsonString);

import 'dart:convert';

BottomBannerModel bottomBannerModelFromJson(String str) => BottomBannerModel.fromJson(json.decode(str));

String bottomBannerModelToJson(BottomBannerModel data) => json.encode(data.toJson());

class BottomBannerModel {
  BottomSliderData? data;

  BottomBannerModel({
    this.data,
  });

  factory BottomBannerModel.fromJson(Map<String, dynamic> json) => BottomBannerModel(
    data: json["data"] == null ? null : BottomSliderData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class BottomSliderData {
  List<Type>? types;

  BottomSliderData({
    this.types,
  });

  factory BottomSliderData.fromJson(Map<String, dynamic> json) => BottomSliderData(
    types: json["types"] == null ? [] : List<Type>.from(json["types"]!.map((x) => Type.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x.toJson())),
  };
}

class Type {
  Settings? settings;

  Type({
    this.settings,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    settings: json["settings"] == null ? null : Settings.fromJson(json["settings"]),
  );

  Map<String, dynamic> toJson() => {
    "settings": settings?.toJson(),
  };
}

class Settings {
  bool? isHome;
  String? layoutType;
  String? productCard;
  List<Bottomslider>? bottomslider;

  Settings({
    this.isHome,
    this.layoutType,
    this.productCard,
    this.bottomslider,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    isHome: json["isHome"],
    layoutType: json["layoutType"],
    productCard: json["productCard"],
    bottomslider: json["bottomslider"] == null ? [] : List<Bottomslider>.from(json["bottomslider"]!.map((x) => Bottomslider.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isHome": isHome,
    "layoutType": layoutType,
    "productCard": productCard,
    "bottomslider": bottomslider == null ? [] : List<dynamic>.from(bottomslider!.map((x) => x.toJson())),
  };
}

class Bottomslider {
  String? thumbnail;
  String? original;
  String? id;

  Bottomslider({
    this.thumbnail,
    this.original,
    this.id,
  });

  factory Bottomslider.fromJson(Map<String, dynamic> json) => Bottomslider(
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
