// To parse this JSON data, do
//
//     final baseModel = baseModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  bool? status;
  String? messege;
  String? role;

  RegisterModel({
    this.status,
    this.messege,
    this.role,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        status: json["status"],
        messege: json["messege"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "messege": messege,
        "role": role,
      };
}
