// To parse this JSON data, do
//
//     final emailLogInModel = emailLogInModelFromJson(jsonString);

import 'dart:convert';

EmailLogInModel emailLogInModelFromJson(String str) => EmailLogInModel.fromJson(json.decode(str));

String emailLogInModelToJson(EmailLogInModel data) => json.encode(data.toJson());

class EmailLogInModel {
  EmailLogInData? data;

  EmailLogInModel({
    this.data,
  });

  factory EmailLogInModel.fromJson(Map<String, dynamic> json) => EmailLogInModel(
    data: json["data"] == null ? null : EmailLogInData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class EmailLogInData {
  Appemaillogin? appemaillogin;

  EmailLogInData({
    this.appemaillogin,
  });

  factory EmailLogInData.fromJson(Map<String, dynamic> json) => EmailLogInData(
    appemaillogin: json["appemaillogin"] == null ? null : Appemaillogin.fromJson(json["appemaillogin"]),
  );

  Map<String, dynamic> toJson() => {
    "appemaillogin": appemaillogin?.toJson(),
  };
}

class Appemaillogin {
  String? token;
  List<String>? permissions;
  String? role;

  Appemaillogin({
    this.token,
    this.permissions,
    this.role,
  });

  factory Appemaillogin.fromJson(Map<String, dynamic> json) => Appemaillogin(
    token: json["token"],
    permissions: json["permissions"] == null ? [] : List<String>.from(json["permissions"]!.map((x) => x)),
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x)),
    "role": role,
  };
}
