// To parse this JSON data, do
//
//     final peopleBuyModel = peopleBuyModelFromJson(jsonString);

import 'dart:convert';

PeopleBuyModel peopleBuyModelFromJson(String str) => PeopleBuyModel.fromJson(json.decode(str));

String peopleBuyModelToJson(PeopleBuyModel data) => json.encode(data.toJson());

class PeopleBuyModel {
  PeopleBuyData? data;

  PeopleBuyModel({
    this.data,
  });

  factory PeopleBuyModel.fromJson(Map<String, dynamic> json) => PeopleBuyModel(
    data: json["data"] == null ? null : PeopleBuyData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class PeopleBuyData {
  List<Type>? types;

  PeopleBuyData({
    this.types,
  });

  factory PeopleBuyData.fromJson(Map<String, dynamic> json) => PeopleBuyData(
    types: json["types"] == null ? [] : List<Type>.from(json["types"]!.map((x) => Type.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x.toJson())),
  };
}

class Type {
  String? id;
  String? name;
  String? language;
  List<String>? translatedLanguages;
  String? slug;
  String? icon;
  DateTime? createdAt;
  DateTime? updatedAt;
  Settings? settings;

  Type({
    this.id,
    this.name,
    this.language,
    this.translatedLanguages,
    this.slug,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.settings,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    id: json["id"],
    name: json["name"],
    language: json["language"],
    translatedLanguages: json["translated_languages"] == null ? [] : List<String>.from(json["translated_languages"]!.map((x) => x)),
    slug: json["slug"],
    icon: json["icon"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    settings: json["settings"] == null ? null : Settings.fromJson(json["settings"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "language": language,
    "translated_languages": translatedLanguages == null ? [] : List<dynamic>.from(translatedLanguages!.map((x) => x)),
    "slug": slug,
    "icon": icon,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "settings": settings?.toJson(),
  };
}

class Settings {
  bool? isHome;
  String? layoutType;
  String? productCard;
  HandpickedProducts? handpickedProducts;

  Settings({
    this.isHome,
    this.layoutType,
    this.productCard,
    this.handpickedProducts,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    isHome: json["isHome"],
    layoutType: json["layoutType"],
    productCard: json["productCard"],
    handpickedProducts: json["handpickedProducts"] == null ? null : HandpickedProducts.fromJson(json["handpickedProducts"]),
  );

  Map<String, dynamic> toJson() => {
    "isHome": isHome,
    "layoutType": layoutType,
    "productCard": productCard,
    "handpickedProducts": handpickedProducts?.toJson(),
  };
}

class HandpickedProducts {
  bool? enable;
  String? title;
  bool? enableSlider;
  List<Product>? products;

  HandpickedProducts({
    this.enable,
    this.title,
    this.enableSlider,
    this.products,
  });

  factory HandpickedProducts.fromJson(Map<String, dynamic> json) => HandpickedProducts(
    enable: json["enable"],
    title: json["title"],
    enableSlider: json["enableSlider"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "enable": enable,
    "title": title,
    "enableSlider": enableSlider,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  String? id;
  String? slug;
  String? name;
  dynamic regularPrice;
  int? salePrice;
  double? minPrice;
  double? maxPrice;
  String? productType;
  int? quantity;
  dynamic qtn;
  bool? isExternal;
  String? unit;
  double? price;
  dynamic externalProductUrl;
  String? status;
  ImageDetails? image;

  Product({
    this.id,
    this.slug,
    this.name,
    this.regularPrice,
    this.salePrice,
    this.minPrice,
    this.maxPrice,
    this.productType,
    this.quantity,
    this.qtn,
    this.isExternal,
    this.unit,
    this.price,
    this.externalProductUrl,
    this.status,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
    regularPrice: json["regular_price"],
    salePrice: json["sale_price"],
    minPrice: json["min_price"]?.toDouble(),
    maxPrice: json["max_price"]?.toDouble(),
    productType: json["product_type"],
    quantity: json["quantity"],
    qtn: json["qtn"],
    isExternal: json["is_external"],
    unit: json["unit"],
    price: json["price"]?.toDouble(),
    externalProductUrl: json["external_product_url"],
    status: json["status"],
    image: json["image"] == null ? null : ImageDetails.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "min_price": minPrice,
    "max_price": maxPrice,
    "product_type": productType,
    "quantity": quantity,
    "qtn": qtn,
    "is_external": isExternal,
    "unit": unit,
    "price": price,
    "external_product_url": externalProductUrl,
    "status": status,
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
