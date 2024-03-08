// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoriesData? data;

  CategoryModel({
    this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    data: json["data"] == null ? null : CategoriesData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class CategoriesData {
  Categories? categories;

  CategoriesData({
    this.categories,
  });

  factory CategoriesData.fromJson(Map<String, dynamic> json) => CategoriesData(
    categories: json["categories"] == null ? null : Categories.fromJson(json["categories"]),
  );

  Map<String, dynamic> toJson() => {
    "categories": categories?.toJson(),
  };
}

class Categories {
  List<CategoriesList>? data;

  Categories({
    this.data,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    data: json["data"] == null ? [] : List<CategoriesList>.from(json["data"]!.map((x) => CategoriesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CategoriesList {
  String? id;
  String? name;
  String? slug;
  dynamic parentId;
  String? language;
  List<String>? translatedLanguages;
  int? productsCount;
  dynamic details;
  String? icon;
  DateTime? createdAt;
  DateTime? updatedAt;
  ImageDetails? image;

  CategoriesList({
    this.id,
    this.name,
    this.slug,
    this.parentId,
    this.language,
    this.translatedLanguages,
    this.productsCount,
    this.details,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  factory CategoriesList.fromJson(Map<String, dynamic> json) => CategoriesList(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    parentId: json["parent_id"],
    language: json["language"],
    translatedLanguages: json["translated_languages"] == null ? [] : List<String>.from(json["translated_languages"]!.map((x) => x)),
    productsCount: json["products_count"],
    details: json["details"],
    icon: json["icon"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    image: json["image"] == null ? null : ImageDetails.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "parent_id": parentId,
    "language": language,
    "translated_languages": translatedLanguages == null ? [] : List<dynamic>.from(translatedLanguages!.map((x) => x)),
    "products_count": productsCount,
    "details": details,
    "icon": icon,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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
