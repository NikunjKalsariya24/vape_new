// To parse this JSON data, do
//
//     final searchProductModel = searchProductModelFromJson(jsonString);

import 'dart:convert';

SearchProductModel searchProductModelFromJson(String str) => SearchProductModel.fromJson(json.decode(str));

String searchProductModelToJson(SearchProductModel data) => json.encode(data.toJson());

class SearchProductModel {
  SearchProductData? data;

  SearchProductModel({
    this.data,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) => SearchProductModel(
    data: json["data"] == null ? null : SearchProductData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class SearchProductData {
  Products? products;

  SearchProductData({
    this.products,
  });

  factory SearchProductData.fromJson(Map<String, dynamic> json) => SearchProductData(
    products: json["products"] == null ? null : Products.fromJson(json["products"]),
  );

  Map<String, dynamic> toJson() => {
    "products": products?.toJson(),
  };
}

class Products {
  List<Datum>? data;
  PaginatorInfo? paginatorInfo;

  Products({
    this.data,
    this.paginatorInfo,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    paginatorInfo: json["paginatorInfo"] == null ? null : PaginatorInfo.fromJson(json["paginatorInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "paginatorInfo": paginatorInfo?.toJson(),
  };
}

class Datum {
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
  String? externalProductUrl;
  String? externalProductButtonText;
  double? salePrice;
  double? maxPrice;
  double? minPrice;
  dynamic? ratings;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  SearchImage? image;
  List<SearchImage>? gallery;
  List<dynamic>? video;
  List<Datum>? relatedProducts;
  List<VariationOption>? variationOptions;
  List<Variation>? variations;

  Datum({
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
    this.inFlashSale,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.gallery,
    this.video,
    this.relatedProducts,
    this.variationOptions,
    this.variations,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    ratings: json["ratings"],
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
    inFlashSale: json["in_flash_sale"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    image: json["image"] == null ? null : SearchImage.fromJson(json["image"]),
    gallery: json["gallery"] == null ? [] : List<SearchImage>.from(json["gallery"]!.map((x) => SearchImage.fromJson(x))),
    video: json["video"] == null ? [] : List<dynamic>.from(json["video"]!.map((x) => x)),
    relatedProducts: json["related_products"] == null ? [] : List<Datum>.from(json["related_products"]!.map((x) => Datum.fromJson(x))),
    variationOptions: json["variation_options"] == null ? [] : List<VariationOption>.from(json["variation_options"]!.map((x) => VariationOption.fromJson(x))),
    variations: json["variations"] == null ? [] : List<Variation>.from(json["variations"]!.map((x) => Variation.fromJson(x))),
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
    "unit": unit,
    "sold_quantity": soldQuantity,
    "in_flash_sale": inFlashSale,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "image": image?.toJson(),
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x.toJson())),
    "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x)),
    "related_products": relatedProducts == null ? [] : List<dynamic>.from(relatedProducts!.map((x) => x.toJson())),
    "variation_options": variationOptions == null ? [] : List<dynamic>.from(variationOptions!.map((x) => x.toJson())),
    "variations": variations == null ? [] : List<dynamic>.from(variations!.map((x) => x.toJson())),
  };
}

class SearchImage {
  String? thumbnail;
  String? original;
  String? id;

  SearchImage({
    this.thumbnail,
    this.original,
    this.id,
  });

  factory SearchImage.fromJson(Map<String, dynamic> json) => SearchImage(
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

class PaginatorInfo {
  int? count;
  int? currentPage;
  int? firstItem;
  bool? hasMorePages;
  int? lastItem;
  int? lastPage;
  int? perPage;
  int? total;

  PaginatorInfo({
    this.count,
    this.currentPage,
    this.firstItem,
    this.hasMorePages,
    this.lastItem,
    this.lastPage,
    this.perPage,
    this.total,
  });

  factory PaginatorInfo.fromJson(Map<String, dynamic> json) => PaginatorInfo(
    count: json["count"],
    currentPage: json["currentPage"],
    firstItem: json["firstItem"],
    hasMorePages: json["hasMorePages"],
    lastItem: json["lastItem"],
    lastPage: json["lastPage"],
    perPage: json["perPage"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "currentPage": currentPage,
    "firstItem": firstItem,
    "hasMorePages": hasMorePages,
    "lastItem": lastItem,
    "lastPage": lastPage,
    "perPage": perPage,
    "total": total,
  };
}
