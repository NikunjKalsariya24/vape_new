// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerData? bannerData;

  BannerModel({
    this.bannerData,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    bannerData: json["data"] == null ? null : BannerData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": bannerData?.toJson(),
  };
}

class BannerData {
  Type? type;

  BannerData({
    this.type,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    type: json["type"] == null ? null : Type.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type?.toJson(),
  };
}

class Type {
  List<Banner>? banners;

  Type({
    this.banners,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    banners: json["banners"] == null ? [] : List<Banner>.from(json["banners"]!.map((x) => Banner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "banners": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x.toJson())),
  };
}

class Banner {
  int? id;
  String? title;
  String? description;
  ImageIcon? imageIcon;

  Banner({
    this.id,
    this.title,
    this.description,
    this.imageIcon,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    imageIcon: json["image"] == null ? null : ImageIcon.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": imageIcon?.toJson(),
  };
}

class ImageIcon {
  String? thumbnail;
  String? original;
  String? id;

  ImageIcon({
    this.thumbnail,
    this.original,
    this.id,
  });

  factory ImageIcon.fromJson(Map<String, dynamic> json) => ImageIcon(
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
