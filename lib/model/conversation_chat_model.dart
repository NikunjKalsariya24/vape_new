// To parse this JSON data, do
//
//     final conversationChatModel = conversationChatModelFromJson(jsonString);

import 'dart:convert';

ConversationChatModel conversationChatModelFromJson(String str) => ConversationChatModel.fromJson(json.decode(str));

String conversationChatModelToJson(ConversationChatModel data) => json.encode(data.toJson());

class ConversationChatModel {
  ConversationChatData? data;

  ConversationChatModel({
    this.data,
  });

  factory ConversationChatModel.fromJson(Map<String, dynamic> json) => ConversationChatModel(
    data: json["data"] == null ? null : ConversationChatData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class ConversationChatData {
  Messages? messages;

  ConversationChatData({
    this.messages,
  });

  factory ConversationChatData.fromJson(Map<String, dynamic> json) => ConversationChatData(
    messages: json["messages"] == null ? null : Messages.fromJson(json["messages"]),
  );

  Map<String, dynamic> toJson() => {
    "messages": messages?.toJson(),
  };
}

class Messages {
  List<ConversationMessageData>? data;

  Messages({
    this.data,
  });

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
    data: json["data"] == null ? [] : List<ConversationMessageData>.from(json["data"]!.map((x) => ConversationMessageData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ConversationMessageData {
  String? id;
  String? userId;
  String? conversationId;
  String? body;
  DateTime? createdAt;
  DateTime? updatedAt;

  ConversationMessageData({
    this.id,
    this.userId,
    this.conversationId,
    this.body,
    this.createdAt,
    this.updatedAt,
  });

  factory ConversationMessageData.fromJson(Map<String, dynamic> json) => ConversationMessageData(
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
