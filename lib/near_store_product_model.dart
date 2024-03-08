// To parse this JSON data, do
//
//     final nearStoreProductModel = nearStoreProductModelFromJson(jsonString);

import 'dart:convert';

NearStoreProductModel nearStoreProductModelFromJson(String str) => NearStoreProductModel.fromJson(json.decode(str));

String nearStoreProductModelToJson(NearStoreProductModel data) => json.encode(data.toJson());

class NearStoreProductModel {
  NearStoreProductData? data;

  NearStoreProductModel({
    this.data,
  });

  factory NearStoreProductModel.fromJson(Map<String, dynamic> json) => NearStoreProductModel(
    data: json["data"] == null ? null : NearStoreProductData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class NearStoreProductData {
  Products? products;

  NearStoreProductData({
    this.products,
  });

  factory NearStoreProductData.fromJson(Map<String, dynamic> json) => NearStoreProductData(
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
  int? salePrice;
  int? maxPrice;
  int? minPrice;
  int? ratings;
  int? totalReviews;
  bool? inWishlist;
  String? sku;
  String? status;
  String? height;
  String? length;
  String? width;
  int? price;
  int? quantity;
  String? unit;
  int? soldQuantity;
  int? inFlashSale;
  dynamic qtn;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? variationOptions;
  List<dynamic>? variations;
  ImageDetails? image;
  List<ImageDetails>? gallery;
  List<dynamic>? video;
  dynamic myReview;
  List<dynamic>? ratingCount;
  List<Datum>? relatedProducts;
  Author? author;
  List<Order>? orders;
  List<Category>? categories;

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
    this.qtn,
    this.createdAt,
    this.updatedAt,
    this.variationOptions,
    this.variations,
    this.image,
    this.gallery,
    this.video,
    this.myReview,
    this.ratingCount,
    this.relatedProducts,
    this.author,
    this.orders,
    this.categories,
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
    salePrice: json["sale_price"],
    maxPrice: json["max_price"],
    minPrice: json["min_price"],
    ratings: json["ratings"],
    totalReviews: json["total_reviews"],
    inWishlist: json["in_wishlist"],
    sku: json["sku"],
    status: json["status"],
    height: json["height"],
    length: json["length"],
    width: json["width"],
    price: json["price"],
    quantity: json["quantity"],
    unit: json["unit"],
    soldQuantity: json["sold_quantity"],
    inFlashSale: json["in_flash_sale"],
    qtn: json["qtn"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    variationOptions: json["variation_options"] == null ? [] : List<dynamic>.from(json["variation_options"]!.map((x) => x)),
    variations: json["variations"] == null ? [] : List<dynamic>.from(json["variations"]!.map((x) => x)),
    image: json["image"] == null ? null : ImageDetails.fromJson(json["image"]),
    gallery: json["gallery"] == null ? [] : List<ImageDetails>.from(json["gallery"]!.map((x) => ImageDetails.fromJson(x))),
    video: json["video"] == null ? [] : List<dynamic>.from(json["video"]!.map((x) => x)),
    myReview: json["my_review"],
    ratingCount: json["rating_count"] == null ? [] : List<dynamic>.from(json["rating_count"]!.map((x) => x)),
    relatedProducts: json["related_products"] == null ? [] : List<Datum>.from(json["related_products"]!.map((x) => Datum.fromJson(x))),
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
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
    "price": price,
    "quantity": quantity,
    "unit": unit,
    "sold_quantity": soldQuantity,
    "in_flash_sale": inFlashSale,
    "qtn": qtn,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "variation_options": variationOptions == null ? [] : List<dynamic>.from(variationOptions!.map((x) => x)),
    "variations": variations == null ? [] : List<dynamic>.from(variations!.map((x) => x)),
    "image": image?.toJson(),
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x.toJson())),
    "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x)),
    "my_review": myReview,
    "rating_count": ratingCount == null ? [] : List<dynamic>.from(ratingCount!.map((x) => x)),
    "related_products": relatedProducts == null ? [] : List<dynamic>.from(relatedProducts!.map((x) => x.toJson())),
    "author": author?.toJson(),
    "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class Author {
  String? id;
  String? name;
  bool? isApproved;
  String? language;
  List<String>? translatedLanguages;
  String? slug;
  String? bio;
  String? quote;
  int? productsCount;
  DateTime? born;
  dynamic death;
  String? languages;
  DateTime? createdAt;
  DateTime? updatedAt;

  Author({
    this.id,
    this.name,
    this.isApproved,
    this.language,
    this.translatedLanguages,
    this.slug,
    this.bio,
    this.quote,
    this.productsCount,
    this.born,
    this.death,
    this.languages,
    this.createdAt,
    this.updatedAt,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"],
    name: json["name"],
    isApproved: json["is_approved"],
    language: json["language"],
    translatedLanguages: json["translated_languages"] == null ? [] : List<String>.from(json["translated_languages"]!.map((x) => x)),
    slug: json["slug"],
    bio: json["bio"],
    quote: json["quote"],
    productsCount: json["products_count"],
    born: json["born"] == null ? null : DateTime.parse(json["born"]),
    death: json["death"],
    languages: json["languages"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_approved": isApproved,
    "language": language,
    "translated_languages": translatedLanguages == null ? [] : List<dynamic>.from(translatedLanguages!.map((x) => x)),
    "slug": slug,
    "bio": bio,
    "quote": quote,
    "products_count": productsCount,
    "born": born?.toIso8601String(),
    "death": death,
    "languages": languages,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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

class Order {
  String? id;
  String? trackingNumber;
  dynamic customerId;
  String? customerContact;
  String? customerName;
  String? language;
  String? parentId;
  String? orderStatus;
  String? paymentStatus;
  int? amount;
  int? salesTax;
  int? total;
  int? paidTotal;
  dynamic paymentId;
  String? paymentGateway;
  dynamic alteredPaymentGateway;
  int? discount;
  int? deliveryFee;
  String? deliveryTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic note;

  Order({
    this.id,
    this.trackingNumber,
    this.customerId,
    this.customerContact,
    this.customerName,
    this.language,
    this.parentId,
    this.orderStatus,
    this.paymentStatus,
    this.amount,
    this.salesTax,
    this.total,
    this.paidTotal,
    this.paymentId,
    this.paymentGateway,
    this.alteredPaymentGateway,
    this.discount,
    this.deliveryFee,
    this.deliveryTime,
    this.createdAt,
    this.updatedAt,
    this.note,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    trackingNumber: json["tracking_number"],
    customerId: json["customer_id"],
    customerContact: json["customer_contact"],
    customerName: json["customer_name"],
    language: json["language"],
    parentId: json["parent_id"],
    orderStatus: json["order_status"],
    paymentStatus: json["payment_status"],
    amount: json["amount"],
    salesTax: json["sales_tax"],
    total: json["total"],
    paidTotal: json["paid_total"],
    paymentId: json["payment_id"],
    paymentGateway: json["payment_gateway"],
    alteredPaymentGateway: json["altered_payment_gateway"],
    discount: json["discount"],
    deliveryFee: json["delivery_fee"],
    deliveryTime: json["delivery_time"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tracking_number": trackingNumber,
    "customer_id": customerId,
    "customer_contact": customerContact,
    "customer_name": customerName,
    "language": language,
    "parent_id": parentId,
    "order_status": orderStatus,
    "payment_status": paymentStatus,
    "amount": amount,
    "sales_tax": salesTax,
    "total": total,
    "paid_total": paidTotal,
    "payment_id": paymentId,
    "payment_gateway": paymentGateway,
    "altered_payment_gateway": alteredPaymentGateway,
    "discount": discount,
    "delivery_fee": deliveryFee,
    "delivery_time": deliveryTime,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "note": note,
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
