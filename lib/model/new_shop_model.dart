// To parse this JSON data, do
//
//     final newShopModel = newShopModelFromJson(jsonString);

import 'dart:convert';

List<NewShopModel> newShopModelFromJson(String str) => List<NewShopModel>.from(json.decode(str).map((x) => NewShopModel.fromJson(x)));

String newShopModelToJson(List<NewShopModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewShopModel {
  int? id;
  int? ownerId;
  String? name;
  String? slug;
  String? description;
  CoverImage? coverImage;
  CoverImage? logo;
  int? isActive;
  Address? address;
  Settings? settings;
  dynamic notifications;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? distance;

  NewShopModel({
    this.id,
    this.ownerId,
    this.name,
    this.slug,
    this.description,
    this.coverImage,
    this.logo,
    this.isActive,
    this.address,
    this.settings,
    this.notifications,
    this.createdAt,
    this.updatedAt,
    this.distance,
  });

  factory NewShopModel.fromJson(Map<String, dynamic> json) => NewShopModel(
    id: json["id"],
    ownerId: json["owner_id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    coverImage: json["cover_image"] == null ? null : CoverImage.fromJson(json["cover_image"]),
    logo: json["logo"] == null ? null : CoverImage.fromJson(json["logo"]),
    isActive: json["is_active"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    settings: json["settings"] == null ? null : Settings.fromJson(json["settings"]),
    notifications: json["notifications"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    distance: json["distance"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner_id": ownerId,
    "name": name,
    "slug": slug,
    "description": description,
    "cover_image": coverImage?.toJson(),
    "logo": logo?.toJson(),
    "is_active": isActive,
    "address": address?.toJson(),
    "settings": settings?.toJson(),
    "notifications": notifications,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "distance": distance,
  };
}

class Address {
  String? zip;
  String? city;
  String? state;
  String? country;
  String? streetAddress;

  Address({
    this.zip,
    this.city,
    this.state,
    this.country,
    this.streetAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    zip: json["zip"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    streetAddress: json["street_address"],
  );

  Map<String, dynamic> toJson() => {
    "zip": zip,
    "city": city,
    "state": state,
    "country": country,
    "street_address": streetAddress,
  };
}

class CoverImage {
  String? id;
  String? original;
  String? thumbnail;

  CoverImage({
    this.id,
    this.original,
    this.thumbnail,
  });

  factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
    id: json["id"],
    original: json["original"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "original": original,
    "thumbnail": thumbnail,
  };
}

class Settings {
  String? contact;
  List<Social>? socials;
  String? website;
  Location? location;
  Notifications? notifications;

  Settings({
    this.contact,
    this.socials,
    this.website,
    this.location,
    this.notifications,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    contact: json["contact"],
    socials: json["socials"] == null ? [] : List<Social>.from(json["socials"]!.map((x) => Social.fromJson(x))),
    website: json["website"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    notifications: json["notifications"] == null ? null : Notifications.fromJson(json["notifications"]),
  );

  Map<String, dynamic> toJson() => {
    "contact": contact,
    "socials": socials == null ? [] : List<dynamic>.from(socials!.map((x) => x.toJson())),
    "website": website,
    "location": location?.toJson(),
    "notifications": notifications?.toJson(),
  };
}

class Location {
  double? lat;
  double? lng;
  String? zip;
  String? city;
  String? state;
  String? country;
  String? formattedAddress;

  Location({
    this.lat,
    this.lng,
    this.zip,
    this.city,
    this.state,
    this.country,
    this.formattedAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    zip: json["zip"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    formattedAddress: json["formattedAddress"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
    "zip": zip,
    "city": city,
    "state": state,
    "country": country,
    "formattedAddress": formattedAddress,
  };
}

class Notifications {
  dynamic email;
  dynamic enable;

  Notifications({
    this.email,
    this.enable,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    email: json["email"],
    enable: json["enable"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "enable": enable,
  };
}

class Social {
  String? url;
  String? icon;

  Social({
    this.url,
    this.icon,
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
    url: json["url"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "icon": icon,
  };
}
