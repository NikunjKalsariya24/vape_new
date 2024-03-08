// To parse this JSON data, do
//
//     final ratingProductModel = ratingProductModelFromJson(jsonString);

import 'dart:convert';

RatingProductModel ratingProductModelFromJson(String str) => RatingProductModel.fromJson(json.decode(str));

String ratingProductModelToJson(RatingProductModel data) => json.encode(data.toJson());

class RatingProductModel {
  RatingProductData? data;

  RatingProductModel({
    this.data,
  });

  factory RatingProductModel.fromJson(Map<String, dynamic> json) => RatingProductModel(
    data: json["data"] == null ? null : RatingProductData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class RatingProductData {
  Reviews? reviews;

  RatingProductData({
    this.reviews,
  });

  factory RatingProductData.fromJson(Map<String, dynamic> json) => RatingProductData(
    reviews: json["reviews"] == null ? null : Reviews.fromJson(json["reviews"]),
  );

  Map<String, dynamic> toJson() => {
    "reviews": reviews?.toJson(),
  };
}

class Reviews {
  List<Datum>? data;
  PaginatorInfo? paginatorInfo;

  Reviews({
    this.data,
    this.paginatorInfo,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
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
  String? comment;
  String? rating;
  String? userId;
  dynamic orderId;
  String? productId;
  dynamic variationOptionId;
  String? shopId;
  int? positiveFeedbacksCount;
  int? negativeFeedbacksCount;
  int? abusiveReportsCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  List<dynamic>? photos;

  Datum({
    this.id,
    this.comment,
    this.rating,
    this.userId,
    this.orderId,
    this.productId,
    this.variationOptionId,
    this.shopId,
    this.positiveFeedbacksCount,
    this.negativeFeedbacksCount,
    this.abusiveReportsCount,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.photos,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    comment: json["comment"],
    rating: json["rating"],
    userId: json["user_id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    variationOptionId: json["variation_option_id"],
    shopId: json["shop_id"],
    positiveFeedbacksCount: json["positive_feedbacks_count"],
    negativeFeedbacksCount: json["negative_feedbacks_count"],
    abusiveReportsCount: json["abusive_reports_count"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    photos: json["photos"] == null ? [] : List<dynamic>.from(json["photos"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "rating": rating,
    "user_id": userId,
    "order_id": orderId,
    "product_id": productId,
    "variation_option_id": variationOptionId,
    "shop_id": shopId,
    "positive_feedbacks_count": positiveFeedbacksCount,
    "negative_feedbacks_count": negativeFeedbacksCount,
    "abusive_reports_count": abusiveReportsCount,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
  };
}

class User {
  Profile? profile;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.profile,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "profile": profile?.toJson(),
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Profile {
  String? id;
  dynamic bio;
  String? contact;
  Avatar? avatar;

  Profile({
    this.id,
    this.bio,
    this.contact,
    this.avatar,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    bio: json["bio"],
    contact: json["contact"],
    avatar: json["avatar"] == null ? null : Avatar.fromJson(json["avatar"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bio": bio,
    "contact": contact,
    "avatar": avatar?.toJson(),
  };
}

class Avatar {
  String? thumbnail;
  String? original;
  String? id;

  Avatar({
    this.thumbnail,
    this.original,
    this.id,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
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
