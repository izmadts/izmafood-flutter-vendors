// To parse this JSON data, do
//
//     final registerPageTwoModel = registerPageTwoModelFromJson(jsonString);

import 'dart:convert';

RegisterPageTwoModel registerPageTwoModelFromJson(String str) =>
    RegisterPageTwoModel.fromJson(json.decode(str));

String registerPageTwoModelToJson(RegisterPageTwoModel data) =>
    json.encode(data.toJson());

class RegisterPageTwoModel {
  bool? status;
  String? success;
  Data? data;

  RegisterPageTwoModel({
    this.status,
    this.success,
    this.data,
  });

  factory RegisterPageTwoModel.fromJson(Map<String, dynamic> json) =>
      RegisterPageTwoModel(
        status: json["status"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  String? radius;
  String? shopName;
  String? shopType;
  String? shopCategory;
  String? slug;
  int? owner;
  String? lat;
  String? lng;
  dynamic faddress;
  String? ipaddress;
  dynamic accountName;
  dynamic accountTitle;
  dynamic accountNumber;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.radius,
    this.shopName,
    this.shopType,
    this.shopCategory,
    this.slug,
    this.owner,
    this.lat,
    this.lng,
    this.faddress,
    this.ipaddress,
    this.accountName,
    this.accountTitle,
    this.accountNumber,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        radius: json["radius"],
        shopName: json["shop_name"],
        shopType: json["shop_type"],
        shopCategory: json["shop_category"],
        slug: json["slug"],
        owner: json["owner"],
        lat: json["lat"],
        lng: json["lng"],
        faddress: json["faddress"],
        ipaddress: json["ipaddress"],
        accountName: json["account_name"],
        accountTitle: json["account_title"],
        accountNumber: json["account_number"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "radius": radius,
        "shop_name": shopName,
        "shop_type": shopType,
        "shop_category": shopCategory,
        "slug": slug,
        "owner": owner,
        "lat": lat,
        "lng": lng,
        "faddress": faddress,
        "ipaddress": ipaddress,
        "account_name": accountName,
        "account_title": accountTitle,
        "account_number": accountNumber,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
