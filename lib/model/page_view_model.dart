// To parse this JSON data, do
//
//     final pageViewModel = pageViewModelFromJson(jsonString);

import 'dart:convert';

PageViewModel pageViewModelFromJson(String str) => PageViewModel.fromJson(json.decode(str));

String pageViewModelToJson(PageViewModel data) => json.encode(data.toJson());

class PageViewModel {
  PageViewData? data;

  PageViewModel({
    this.data,
  });

  factory PageViewModel.fromJson(Map<String, dynamic> json) => PageViewModel(
    data: json["data"] == null ? null : PageViewData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class PageViewData {
  Type? type;

  PageViewData({
    this.type,
  });

  factory PageViewData.fromJson(Map<String, dynamic> json) => PageViewData(
    type: json["type"] == null ? null : Type.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type?.toJson(),
  };
}

class Type {
  Settings? settings;

  Type({
    this.settings,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    settings: json["settings"] == null ? null : Settings.fromJson(json["settings"]),
  );

  Map<String, dynamic> toJson() => {
    "settings": settings?.toJson(),
  };
}

class Settings {
  String? pageViews;

  Settings({
    this.pageViews,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    pageViews: json["pageViews"],
  );

  Map<String, dynamic> toJson() => {
    "pageViews": pageViews,
  };
}
