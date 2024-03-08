// To parse this JSON data, do
//
//     final logoModel = logoModelFromJson(jsonString);

import 'dart:convert';

LogoModel logoModelFromJson(String str) => LogoModel.fromJson(json.decode(str));

String logoModelToJson(LogoModel data) => json.encode(data.toJson());

class LogoModel {
  LogoData? data;

  LogoModel({
    this.data,
  });

  factory LogoModel.fromJson(Map<String, dynamic> json) => LogoModel(
    data: json["data"] == null ? null : LogoData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class LogoData {
  Settings? settings;

  LogoData({
    this.settings,
  });

  factory LogoData.fromJson(Map<String, dynamic> json) => LogoData(
    settings: json["settings"] == null ? null : Settings.fromJson(json["settings"]),
  );

  Map<String, dynamic> toJson() => {
    "settings": settings?.toJson(),
  };
}

class Settings {
  Options? options;

  Settings({
    this.options,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    options: json["options"] == null ? null : Options.fromJson(json["options"]),
  );

  Map<String, dynamic> toJson() => {
    "options": options?.toJson(),
  };
}

class Options {
  Logo? logo;

  Options({
    this.logo,
  });

  factory Options.fromJson(Map<String, dynamic> json) => Options(
    logo: json["logo"] == null ? null : Logo.fromJson(json["logo"]),
  );

  Map<String, dynamic> toJson() => {
    "logo": logo?.toJson(),
  };
}

class Logo {
  String? thumbnail;
  String? original;
  String? id;

  Logo({
    this.thumbnail,
    this.original,
    this.id,
  });

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
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
