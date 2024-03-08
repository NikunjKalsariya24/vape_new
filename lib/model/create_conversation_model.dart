// To parse this JSON data, do
//
//     final createConversationModel = createConversationModelFromJson(jsonString);

import 'dart:convert';

CreateConversationModel createConversationModelFromJson(String str) => CreateConversationModel.fromJson(json.decode(str));

String createConversationModelToJson(CreateConversationModel data) => json.encode(data.toJson());

class CreateConversationModel {
  CreateConversationData? data;

  CreateConversationModel({
    this.data,
  });

  factory CreateConversationModel.fromJson(Map<String, dynamic> json) => CreateConversationModel(
    data: json["data"] == null ? null : CreateConversationData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class CreateConversationData {
  CreateConversation? createConversation;

  CreateConversationData({
    this.createConversation,
  });

  factory CreateConversationData.fromJson(Map<String, dynamic> json) => CreateConversationData(
    createConversation: json["createConversation"] == null ? null : CreateConversation.fromJson(json["createConversation"]),
  );

  Map<String, dynamic> toJson() => {
    "createConversation": createConversation?.toJson(),
  };
}

class CreateConversation {
  String? id;
  String? userId;
  String? shopId;
  int? unseen;
  DateTime? createdAt;
  DateTime? updatedAt;

  CreateConversation({
    this.id,
    this.userId,
    this.shopId,
    this.unseen,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateConversation.fromJson(Map<String, dynamic> json) => CreateConversation(
    id: json["id"],
    userId: json["user_id"],
    shopId: json["shop_id"],
    unseen: json["unseen"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "shop_id": shopId,
    "unseen": unseen,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
