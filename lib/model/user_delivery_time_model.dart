// To parse this JSON data, do
//
//     final userDeliveryTimeModel = userDeliveryTimeModelFromJson(jsonString);

import 'dart:convert';

UserDeliveryTimeModel userDeliveryTimeModelFromJson(String str) => UserDeliveryTimeModel.fromJson(json.decode(str));

String userDeliveryTimeModelToJson(UserDeliveryTimeModel data) => json.encode(data.toJson());

class UserDeliveryTimeModel {
  UserDeliveryTimeData? data;

  UserDeliveryTimeModel({
    this.data,
  });

  factory UserDeliveryTimeModel.fromJson(Map<String, dynamic> json) => UserDeliveryTimeModel(
    data: json["data"] == null ? null : UserDeliveryTimeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class UserDeliveryTimeData {
  Settings? settings;

  UserDeliveryTimeData({
    this.settings,
  });

  factory UserDeliveryTimeData.fromJson(Map<String, dynamic> json) => UserDeliveryTimeData(
    settings: json["settings"] == null ? null : Settings.fromJson(json["settings"]),
  );

  Map<String, dynamic> toJson() => {
    "settings": settings?.toJson(),
  };
}

class Settings {
  String? id;
  String? language;
  Options? options;

  Settings({
    this.id,
    this.language,
    this.options,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    id: json["id"],
    language: json["language"],
    options: json["options"] == null ? null : Options.fromJson(json["options"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "language": language,
    "options": options?.toJson(),
  };
}

class Options {
  List<DeliveryTime>? deliveryTime;

  Options({
    this.deliveryTime,
  });

  factory Options.fromJson(Map<String, dynamic> json) => Options(
    deliveryTime: json["deliveryTime"] == null ? [] : List<DeliveryTime>.from(json["deliveryTime"]!.map((x) => DeliveryTime.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "deliveryTime": deliveryTime == null ? [] : List<dynamic>.from(deliveryTime!.map((x) => x.toJson())),
  };
}

class DeliveryTime {
  String? title;
  dynamic slug;
  dynamic language;
  dynamic translatedLanguages;
  String? description;
  dynamic icon;
  dynamic createdAt;
  dynamic updatedAt;

  DeliveryTime({
    this.title,
    this.slug,
    this.language,
    this.translatedLanguages,
    this.description,
    this.icon,
    this.createdAt,
    this.updatedAt,
  });

  factory DeliveryTime.fromJson(Map<String, dynamic> json) => DeliveryTime(
    title: json["title"],
    slug: json["slug"],
    language: json["language"],
    translatedLanguages: json["translated_languages"],
    description: json["description"],
    icon: json["icon"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "slug": slug,
    "language": language,
    "translated_languages": translatedLanguages,
    "description": description,
    "icon": icon,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
