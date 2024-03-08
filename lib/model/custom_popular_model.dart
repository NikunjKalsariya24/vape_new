// To parse this JSON data, do
//
//     final customPopularModel = customPopularModelFromJson(jsonString);

import 'dart:convert';

CustomPopularModel customPopularModelFromJson(String str) => CustomPopularModel.fromJson(json.decode(str));

String customPopularModelToJson(CustomPopularModel data) => json.encode(data.toJson());

class CustomPopularModel {
  CustomPopularData? data;

  CustomPopularModel({
    this.data,
  });

  factory CustomPopularModel.fromJson(Map<String, dynamic> json) => CustomPopularModel(
    data: json["data"] == null ? null : CustomPopularData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class CustomPopularData {
  List<Type>? types;

  CustomPopularData({
    this.types,
  });

  factory CustomPopularData.fromJson(Map<String, dynamic> json) => CustomPopularData(
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
  List<Customeproduct>? customeproduct;

  Settings({
    this.isHome,
    this.layoutType,
    this.productCard,
    this.customeproduct,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    isHome: json["isHome"],
    layoutType: json["layoutType"],
    productCard: json["productCard"],
    customeproduct: json["customeproduct"] == null ? [] : List<Customeproduct>.from(json["customeproduct"]!.map((x) => Customeproduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isHome": isHome,
    "layoutType": layoutType,
    "productCard": productCard,
    "customeproduct": customeproduct == null ? [] : List<dynamic>.from(customeproduct!.map((x) => x.toJson())),
  };
}

class Customeproduct {
  String? title;
  String? category;
  List<Product>? products;

  Customeproduct({
    this.title,
    this.category,
    this.products,
  });

  factory Customeproduct.fromJson(Map<String, dynamic> json) => Customeproduct(
    title: json["title"],
    category: json["category"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "category": category,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  String? id;
  String? slug;
  String? name;
  dynamic regularPrice;
  double? salePrice;
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
    salePrice: json["sale_price"]?.toDouble(),
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
