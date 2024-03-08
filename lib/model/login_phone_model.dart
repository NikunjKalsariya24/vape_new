// To parse this JSON data, do
//
//     final logInPhoneModel = logInPhoneModelFromJson(jsonString);

import 'dart:convert';

LogInPhoneModel logInPhoneModelFromJson(String str) => LogInPhoneModel.fromJson(json.decode(str));

String logInPhoneModelToJson(LogInPhoneModel data) => json.encode(data.toJson());

class LogInPhoneModel {
  Data? data;

  LogInPhoneModel({
    this.data,
  });

  // LogInPhoneModel.fromJson(Map<String, dynamic> json) {
  //   print("Json ${json}");
  //   LogInPhoneModel(
  //     data: json["data"] == null ? null : Data.fromJson(json["data"]),
  //   );
  // }
  factory LogInPhoneModel.fromJson(Map<String, dynamic> json) => LogInPhoneModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  Rcustomeotpverification? rcustomeotpverification;

  Data({
    this.rcustomeotpverification,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    rcustomeotpverification: json["rcustomeotpverification"] == null ? null : Rcustomeotpverification.fromJson(json["rcustomeotpverification"]),
  );

  Map<String, dynamic> toJson() => {
    "rcustomeotpverification": rcustomeotpverification?.toJson(),
  };
}

class Rcustomeotpverification {
  String? token;
  List<String>? permissions;
  String? role;

  Rcustomeotpverification({
    this.token,
    this.permissions,
    this.role,
  });

  factory Rcustomeotpverification.fromJson(Map<String, dynamic> json) => Rcustomeotpverification(
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
