// To parse this JSON data, do
//
//     final productDetailsViewModel = productDetailsViewModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsViewModel productDetailsViewModelFromJson(String str) => ProductDetailsViewModel.fromJson(json.decode(str));

String productDetailsViewModelToJson(ProductDetailsViewModel data) => json.encode(data.toJson());

class ProductDetailsViewModel {
  ProductDetailsViewData? data;

  ProductDetailsViewModel({
    this.data,
  });

  factory ProductDetailsViewModel.fromJson(Map<String, dynamic> json) => ProductDetailsViewModel(
    data: json["data"] == null ? null : ProductDetailsViewData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class ProductDetailsViewData {
  Product? product;

  ProductDetailsViewData({
    this.product,
  });

  factory ProductDetailsViewData.fromJson(Map<String, dynamic> json) => ProductDetailsViewData(
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
  };
}

class Product {
  String? id;
  String? name;
  String? slug;
  ImageDetails? image;
  String? description;
  String? unit;
  dynamic salePrice;
  List<Category>? categories;
  List<ImageDetails>? gallery;
  Shop? shop;
  List<VariationOption>? variationOptions;
  List<Variation>? variations;
  dynamic ratings;
  List<Attributeslist>? attributeslist;
  dynamic maxPrice;
  dynamic qtn;

  Product({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.description,
    this.unit,
    this.salePrice,
    this.categories,
    this.gallery,
    this.shop,
    this.variationOptions,
    this.variations,
    this.ratings,
    this.attributeslist,
    this.maxPrice,
    this.qtn
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"] == null ? null : ImageDetails.fromJson(json["image"]),
    description: json["description"],
    unit: json["unit"],
    salePrice: json["sale_price"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    gallery: json["gallery"] == null ? [] : List<ImageDetails>.from(json["gallery"]!.map((x) => ImageDetails.fromJson(x))),
    shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
    variationOptions: json["variation_options"] == null ? [] : List<VariationOption>.from(json["variation_options"]!.map((x) => VariationOption.fromJson(x))),
    variations: json["variations"] == null ? [] : List<Variation>.from(json["variations"]!.map((x) => Variation.fromJson(x))),
    ratings: json["ratings"],
    attributeslist: json["attributeslist"] == null ? [] : List<Attributeslist>.from(json["attributeslist"]!.map((x) => Attributeslist.fromJson(x))),
    maxPrice: json["max_price"],
    qtn: json["qtn"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": image?.toJson(),
    "description": description,
    "unit": unit,
    "sale_price": salePrice,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x.toJson())),
    "shop": shop?.toJson(),
    "variation_options": variationOptions == null ? [] : List<dynamic>.from(variationOptions!.map((x) => x.toJson())),
    "variations": variations == null ? [] : List<dynamic>.from(variations!.map((x) => x.toJson())),
    "ratings": ratings,
    "attributeslist": attributeslist == null ? [] : List<dynamic>.from(attributeslist!.map((x) => x.toJson())),
    "max_price": maxPrice,
    "qtn": qtn,
  };
}

class Attributeslist {
  String? key;
  List<Datum>? data;

  Attributeslist({
    this.key,
    this.data,
  });

  factory Attributeslist.fromJson(Map<String, dynamic> json) => Attributeslist(
    key: json["key"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? avId;
  String? avValue;
  String? attributeId;
  dynamic attributeQuantity;

  Datum({
    this.avId,
    this.avValue,
    this.attributeId,
    this.attributeQuantity
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    avId: json["av_id"],
    avValue: json["av_value"],
    attributeId: json["attribute_id"],
    attributeQuantity: json["attribute_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "av_id": avId,
    "av_value": avValue,
    "attribute_id": attributeId,
    "attribute_quantity": attributeQuantity,
  };
}

class Category {
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

  Category({
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
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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

class Shop {
  String? id;
  String? ownerId;
  bool? isActive;
  int? ordersCount;
  int? productsCount;
  String? name;
  String? slug;
  String? description;
  dynamic distance;
  dynamic lat;
  dynamic lng;
  DateTime? createdAt;
  DateTime? updatedAt;

  Shop({
    this.id,
    this.ownerId,
    this.isActive,
    this.ordersCount,
    this.productsCount,
    this.name,
    this.slug,
    this.description,
    this.distance,
    this.lat,
    this.lng,
    this.createdAt,
    this.updatedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["id"],
    ownerId: json["owner_id"],
    isActive: json["is_active"],
    ordersCount: json["orders_count"],
    productsCount: json["products_count"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    distance: json["distance"],
    lat: json["lat"],
    lng: json["lng"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner_id": ownerId,
    "is_active": isActive,
    "orders_count": ordersCount,
    "products_count": productsCount,
    "name": name,
    "slug": slug,
    "description": description,
    "distance": distance,
    "lat": lat,
    "lng": lng,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class VariationOption {
  String? id;
  String? title;
  String? language;
  int? price;
  List<dynamic>? blockedDates;
  String? sku;
  bool? isDisable;
  bool? isDigital;
  dynamic salePrice;
  int? quantity;
  int? soldQuantity;

  VariationOption({
    this.id,
    this.title,
    this.language,
    this.price,
    this.blockedDates,
    this.sku,
    this.isDisable,
    this.isDigital,
    this.salePrice,
    this.quantity,
    this.soldQuantity,
  });

  factory VariationOption.fromJson(Map<String, dynamic> json) => VariationOption(
    id: json["id"],
    title: json["title"],
    language: json["language"],
    price: json["price"],
    blockedDates: json["blocked_dates"] == null ? [] : List<dynamic>.from(json["blocked_dates"]!.map((x) => x)),
    sku: json["sku"],
    isDisable: json["is_disable"],
    isDigital: json["is_digital"],
    salePrice: json["sale_price"],
    quantity: json["quantity"],
    soldQuantity: json["sold_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "language": language,
    "price": price,
    "blocked_dates": blockedDates == null ? [] : List<dynamic>.from(blockedDates!.map((x) => x)),
    "sku": sku,
    "is_disable": isDisable,
    "is_digital": isDigital,
    "sale_price": salePrice,
    "quantity": quantity,
    "sold_quantity": soldQuantity,
  };
}

class Variation {
  String? id;
  String? value;
  String? meta;
  String? attributeId;
  String? language;

  Variation({
    this.id,
    this.value,
    this.meta,
    this.attributeId,
    this.language,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
    id: json["id"],
    value: json["value"],
    meta: json["meta"],
    attributeId: json["attribute_id"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "meta": meta,
    "attribute_id": attributeId,
    "language": language,
  };
}
