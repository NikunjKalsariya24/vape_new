// To parse this JSON data, do
//
//     final userAddressModel = userAddressModelFromJson(jsonString);

import 'dart:convert';

UserAddressModel userAddressModelFromJson(String str) => UserAddressModel.fromJson(json.decode(str));

String userAddressModelToJson(UserAddressModel data) => json.encode(data.toJson());

class UserAddressModel {
  UserAddressData? data;

  UserAddressModel({
    this.data,
  });

  factory UserAddressModel.fromJson(Map<String, dynamic> json) => UserAddressModel(
    data: json["data"] == null ? null : UserAddressData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class UserAddressData {
  Me? me;

  UserAddressData({
    this.me,
  });

  factory UserAddressData.fromJson(Map<String, dynamic> json) => UserAddressData(
    me: json["me"] == null ? null : Me.fromJson(json["me"]),
  );

  Map<String, dynamic> toJson() => {
    "me": me?.toJson(),
  };
}

class Me {
  List<AddressElement>? address;

  Me({
    this.address,
  });

  factory Me.fromJson(Map<String, dynamic> json) => Me(
    address: json["address"] == null ? [] : List<AddressElement>.from(json["address"]!.map((x) => AddressElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "address": address == null ? [] : List<dynamic>.from(address!.map((x) => x.toJson())),
  };
}

class AddressElement {
  String? id;
  String? title;
  bool? addressDefault;
  String? type;
  AddressAddress? address;
  Location? location;

  AddressElement({
    this.id,
    this.title,
    this.addressDefault,
    this.type,
    this.address,
    this.location,
  });

  factory AddressElement.fromJson(Map<String, dynamic> json) => AddressElement(
    id: json["id"],
    title: json["title"],
    addressDefault: json["default"],
    type: json["type"],
    address: json["address"] == null ? null : AddressAddress.fromJson(json["address"]),
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "default": addressDefault,
    "type": type,
    "address": address?.toJson(),
    "location": location?.toJson(),
  };
}

class AddressAddress {
  String? streetAddress;
  String? country;
  String? city;
  String? state;
  String? zip;

  AddressAddress({
    this.streetAddress,
    this.country,
    this.city,
    this.state,
    this.zip,
  });

  factory AddressAddress.fromJson(Map<String, dynamic> json) => AddressAddress(
    streetAddress: json["street_address"],
    country: json["country"],
    city: json["city"],
    state: json["state"],
    zip: json["zip"],
  );

  Map<String, dynamic> toJson() => {
    "street_address": streetAddress,
    "country": country,
    "city": city,
    "state": state,
    "zip": zip,
  };
}

class Location {
  double? lat;
  double? lng;
  dynamic streetNumber;
  dynamic route;
  String? streetAddress;
  String? city;
  String? state;
  String? country;
  dynamic zip;
  String? formattedAddress;

  Location({
    this.lat,
    this.lng,
    this.streetNumber,
    this.route,
    this.streetAddress,
    this.city,
    this.state,
    this.country,
    this.zip,
    this.formattedAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    streetNumber: json["street_number"],
    route: json["route"],
    streetAddress: json["street_address"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    zip: json["zip"],
    formattedAddress: json["formattedAddress"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
    "street_number": streetNumber,
    "route": route,
    "street_address": streetAddress,
    "city": city,
    "state": state,
    "country": country,
    "zip": zip,
    "formattedAddress": formattedAddress,
  };
}
