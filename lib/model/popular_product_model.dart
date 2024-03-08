// To parse this JSON data, do
//
//     final popularProductModel = popularProductModelFromJson(jsonString);

import 'dart:convert';

PopularProductModel popularProductModelFromJson(String str) => PopularProductModel.fromJson(json.decode(str));

String popularProductModelToJson(PopularProductModel data) => json.encode(data.toJson());

class PopularProductModel {
  PopularProductData? data;

  PopularProductModel({
    this.data,
  });

  factory PopularProductModel.fromJson(Map<String, dynamic> json) => PopularProductModel(
    data: json["data"] == null ? null : PopularProductData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class PopularProductData {
  List<PopularProduct>? popularProducts;

  PopularProductData({
    this.popularProducts,
  });

  factory PopularProductData.fromJson(Map<String, dynamic> json) => PopularProductData(
    popularProducts: json["popularProducts"] == null ? [] : List<PopularProduct>.from(json["popularProducts"]!.map((x) => PopularProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "popularProducts": popularProducts == null ? [] : List<dynamic>.from(popularProducts!.map((x) => x.toJson())),
  };
}

class PopularProduct {
  String? id;
  String? name;
  String? slug;
  String? language;
  List<String>? translatedLanguages;
  String? productType;
  String? shopId;
  String? authorId;
  String? manufacturerId;
  List<dynamic>? blockedDates;
  String? description;
  bool? inStock;
  bool? isTaxable;
  bool? isDigital;
  bool? isExternal;
  dynamic externalProductUrl;
  dynamic externalProductButtonText;
  double? salePrice;
  double? maxPrice;
  double? minPrice;
  double? ratings;
  int? totalReviews;
  bool? inWishlist;
  String? sku;
  String? status;
  String? height;
  String? length;
  String? width;
  double? price;
  int? quantity;
  String? unit;
  int? soldQuantity;
  int? inFlashSale;
  dynamic qtn;
  DateTime? createdAt;
  DateTime? updatedAt;
  ImageDetails? image;

  PopularProduct({
    this.id,
    this.name,
    this.slug,
    this.language,
    this.translatedLanguages,
    this.productType,
    this.shopId,
    this.authorId,
    this.manufacturerId,
    this.blockedDates,
    this.description,
    this.inStock,
    this.isTaxable,
    this.isDigital,
    this.isExternal,
    this.externalProductUrl,
    this.externalProductButtonText,
    this.salePrice,
    this.maxPrice,
    this.minPrice,
    this.ratings,
    this.totalReviews,
    this.inWishlist,
    this.sku,
    this.status,
    this.height,
    this.length,
    this.width,
    this.price,
    this.quantity,
    this.unit,
    this.soldQuantity,
    this.qtn,
    this.inFlashSale,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  factory PopularProduct.fromJson(Map<String, dynamic> json) => PopularProduct(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    language: json["language"],
    translatedLanguages: json["translated_languages"] == null ? [] : List<String>.from(json["translated_languages"]!.map((x) => x)),
    productType: json["product_type"],
    shopId: json["shop_id"],
    authorId: json["author_id"],
    manufacturerId: json["manufacturer_id"],
    blockedDates: json["blocked_dates"] == null ? [] : List<dynamic>.from(json["blocked_dates"]!.map((x) => x)),
    description: json["description"],
    inStock: json["in_stock"],
    isTaxable: json["is_taxable"],
    isDigital: json["is_digital"],
    isExternal: json["is_external"],
    externalProductUrl: json["external_product_url"],
    externalProductButtonText: json["external_product_button_text"],
    salePrice: json["sale_price"]?.toDouble(),
    maxPrice: json["max_price"]?.toDouble(),
    minPrice: json["min_price"]?.toDouble(),
    ratings: json["ratings"]?.toDouble(),
    totalReviews: json["total_reviews"],
    inWishlist: json["in_wishlist"],
    sku: json["sku"],
    status: json["status"],
    height: json["height"],
    length: json["length"],
    width: json["width"],
    price: json["price"]?.toDouble(),
    quantity: json["quantity"],
    unit: json["unit"],
    soldQuantity: json["sold_quantity"],
    qtn: json["qtn"],
    inFlashSale: json["in_flash_sale"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    image: json["image"] == null ? null : ImageDetails.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "language": language,
    "translated_languages": translatedLanguages == null ? [] : List<dynamic>.from(translatedLanguages!.map((x) => x)),
    "product_type": productType,
    "shop_id": shopId,
    "author_id": authorId,
    "manufacturer_id": manufacturerId,
    "blocked_dates": blockedDates == null ? [] : List<dynamic>.from(blockedDates!.map((x) => x)),
    "description": description,
    "in_stock": inStock,
    "is_taxable": isTaxable,
    "is_digital": isDigital,
    "is_external": isExternal,
    "external_product_url": externalProductUrl,
    "external_product_button_text": externalProductButtonText,
    "sale_price": salePrice,
    "max_price": maxPrice,
    "min_price": minPrice,
    "ratings": ratings,
    "total_reviews": totalReviews,
    "in_wishlist": inWishlist,
    "sku": sku,
    "status": status,
    "height": height,
    "length": length,
    "width": width,
    "price": price,
    "quantity": quantity,
    "qtn": qtn,
    "unit": unit,
    "sold_quantity": soldQuantity,
    "in_flash_sale": inFlashSale,
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
