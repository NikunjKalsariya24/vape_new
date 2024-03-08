// To parse this JSON data, do
//
//     final createMessageModel = createMessageModelFromJson(jsonString);

import 'dart:convert';

CreateMessageModel createMessageModelFromJson(String str) => CreateMessageModel.fromJson(json.decode(str));

String createMessageModelToJson(CreateMessageModel data) => json.encode(data.toJson());

class CreateMessageModel {
  CreateMessageData? data;

  CreateMessageModel({
    this.data,
  });

  factory CreateMessageModel.fromJson(Map<String, dynamic> json) => CreateMessageModel(
    data: json["data"] == null ? null : CreateMessageData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class CreateMessageData {
  CreateMessage? createMessage;

  CreateMessageData({
    this.createMessage,
  });

  factory CreateMessageData.fromJson(Map<String, dynamic> json) => CreateMessageData(
    createMessage: json["createMessage"] == null ? null : CreateMessage.fromJson(json["createMessage"]),
  );

  Map<String, dynamic> toJson() => {
    "createMessage": createMessage?.toJson(),
  };
}

class CreateMessage {
  String? id;
  String? userId;
  String? conversationId;
  String? body;
  DateTime? createdAt;
  DateTime? updatedAt;

  CreateMessage({
    this.id,
    this.userId,
    this.conversationId,
    this.body,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateMessage.fromJson(Map<String, dynamic> json) => CreateMessage(
    id: json["id"],
    userId: json["user_id"],
    conversationId: json["conversation_id"],
    body: json["body"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "conversation_id": conversationId,
    "body": body,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
