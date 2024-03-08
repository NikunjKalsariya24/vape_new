// To parse this JSON data, do
//
//     final flashSaleModel = flashSaleModelFromJson(jsonString);

import 'dart:convert';

FlashSaleModel flashSaleModelFromJson(String str) => FlashSaleModel.fromJson(json.decode(str));

String flashSaleModelToJson(FlashSaleModel data) => json.encode(data.toJson());

class FlashSaleModel {
  FlashSaleData? data;

  FlashSaleModel({
    this.data,
  });

  factory FlashSaleModel.fromJson(Map<String, dynamic> json) => FlashSaleModel(
    data: json["data"] == null ? null : FlashSaleData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class FlashSaleData {
  FlashSales? flashSales;

  FlashSaleData({
    this.flashSales,
  });

  factory FlashSaleData.fromJson(Map<String, dynamic> json) => FlashSaleData(
    flashSales: json["flashSales"] == null ? null : FlashSales.fromJson(json["flashSales"]),
  );

  Map<String, dynamic> toJson() => {
    "flashSales": flashSales?.toJson(),
  };
}

class FlashSales {
  List<Datum>? data;

  FlashSales({
    this.data,
  });

  factory FlashSales.fromJson(Map<String, dynamic> json) => FlashSales(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? title;
  String? slug;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  bool? saleStatus;
  String? type;
  int? rate;
  String? language;
  List<String>? translatedLanguages;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.startDate,
    this.endDate,
    this.saleStatus,
    this.type,
    this.rate,
    this.language,
    this.translatedLanguages,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    description: json["description"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    saleStatus: json["sale_status"],
    type: json["type"],
    rate: json["rate"],
    language: json["language"],
    translatedLanguages: json["translated_languages"] == null ? [] : List<String>.from(json["translated_languages"]!.map((x) => x)),
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "description": description,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "sale_status": saleStatus,
    "type": type,
    "rate": rate,
    "language": language,
    "translated_languages": translatedLanguages == null ? [] : List<dynamic>.from(translatedLanguages!.map((x) => x)),
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
