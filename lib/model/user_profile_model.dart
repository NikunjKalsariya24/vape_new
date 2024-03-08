// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
  UserProfileData? data;

  UserProfileModel({
    this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    data: json["data"] == null ? null : UserProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class UserProfileData {
  Me? me;

  UserProfileData({
    this.me,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) => UserProfileData(
    me: json["me"] == null ? null : Me.fromJson(json["me"]),
  );

  Map<String, dynamic> toJson() => {
    "me": me?.toJson(),
  };
}

class Me {
  String? id;
  String? name;
  String? email;
  dynamic shopId;
  dynamic notificationToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Permission>? permissions;
  bool? isActive;
  List<dynamic>? address;
  Profile? profile;

  Me({
    this.id,
    this.name,
    this.email,
    this.shopId,
    this.notificationToken,
    this.createdAt,
    this.updatedAt,
    this.permissions,
    this.isActive,
    this.address,
    this.profile,
  });

  factory Me.fromJson(Map<String, dynamic> json) => Me(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    shopId: json["shop_id"],
    notificationToken: json["notification_token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    permissions: json["permissions"] == null ? [] : List<Permission>.from(json["permissions"]!.map((x) => Permission.fromJson(x))),
    isActive: json["is_active"],
    address: json["address"] == null ? [] : List<dynamic>.from(json["address"]!.map((x) => x)),
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "shop_id": shopId,
    "notification_token": notificationToken,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x.toJson())),
    "is_active": isActive,
    "address": address == null ? [] : List<dynamic>.from(address!.map((x) => x)),
    "profile": profile?.toJson(),
  };
}

class Permission {
  String? id;
  String? name;

  Permission({
    this.id,
    this.name,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Profile {
  String? id;
  dynamic bio;
  String? contact;
  dynamic avatar;
  dynamic notifications;

  Profile({
    this.id,
    this.bio,
    this.contact,
    this.avatar,
    this.notifications,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    bio: json["bio"],
    contact: json["contact"],
    avatar: json["avatar"],
    notifications: json["notifications"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bio": bio,
    "contact": contact,
    "avatar": avatar,
    "notifications": notifications,
  };
}
