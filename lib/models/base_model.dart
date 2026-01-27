// To parse this JSON data, do
//
//     final baseModel = baseModelFromJson(jsonString);

import 'dart:convert';

BaseModel baseModelFromJson(String str) => BaseModel.fromJson(json.decode(str));

String baseModelToJson(BaseModel data) => json.encode(data.toJson());

class BaseModel {
  bool? status;
  String? messege;

  BaseModel({
    this.status,
    this.messege,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        status: json["status"],
        messege: json["messege"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "messege": messege,
      };
}
