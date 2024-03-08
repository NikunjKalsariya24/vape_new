// To parse this JSON data, do
//
//     final categoryDetailsModel = categoryDetailsModelFromJson(jsonString);

import 'dart:convert';

CategoryDetailsModel categoryDetailsModelFromJson(String str) => CategoryDetailsModel.fromJson(json.decode(str));

String categoryDetailsModelToJson(CategoryDetailsModel data) => json.encode(data.toJson());

class CategoryDetailsModel {
  CategoryDetailsData? data;

  CategoryDetailsModel({
    this.data,
  });

  factory CategoryDetailsModel.fromJson(Map<String, dynamic> json) => CategoryDetailsModel(
    data: json["data"] == null ? null : CategoryDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class CategoryDetailsData {
  Categories? categories;

  CategoryDetailsData({
    this.categories,
  });

  factory CategoryDetailsData.fromJson(Map<String, dynamic> json) => CategoryDetailsData(
    categories: json["categories"] == null ? null : Categories.fromJson(json["categories"]),
  );

  Map<String, dynamic> toJson() => {
    "categories": categories?.toJson(),
  };
}

class Categories {
  List<Datum>? data;

  Categories({
    this.data,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  List<Product>? products;

  Datum({
    this.products,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  String? id;
  String? name;
  String? slug;
  String? language;
  List<String>? translatedLanguages;
  String? productType;
  String? shopId;
  dynamic authorId;
  dynamic manufacturerId;
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
  dynamic qtn;
  int? totalReviews;
  bool? inWishlist;
  String? sku;
  String? status;
  dynamic height;
  dynamic length;
  dynamic width;
  double? price;
  int? quantity;
  String? unit;
  int? soldQuantity;
  int? inFlashSale;
  DateTime? createdAt;
  DateTime? updatedAt;
  ImageDetails? image;
  List<ImageDetails>? gallery;
  List<Category>? categories;

  Product({
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
    this.qtn,
    this.quantity,
    this.unit,
    this.soldQuantity,
    this.inFlashSale,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.gallery,
    this.categories,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
    qtn: json["qtn"],
    sku: json["sku"],
    status: json["status"],
    height: json["height"],
    length: json["length"],
    width: json["width"],
    price: json["price"]?.toDouble(),
    quantity: json["quantity"],
    unit: json["unit"],
    soldQuantity: json["sold_quantity"],
    inFlashSale: json["in_flash_sale"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    image: json["image"] == null ? null : ImageDetails.fromJson(json["image"]),
    gallery: json["gallery"] == null ? [] : List<ImageDetails>.from(json["gallery"]!.map((x) => ImageDetails.fromJson(x))),
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
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
    "qtn": qtn,
    "price": price,
    "quantity": quantity,
    "unit": unit,
    "sold_quantity": soldQuantity,
    "in_flash_sale": inFlashSale,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "image": image?.toJson(),
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x.toJson())),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class Category {
  String? name;

  Category({
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
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
