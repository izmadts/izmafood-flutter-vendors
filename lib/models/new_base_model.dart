// To parse this JSON data, do
//
//     final newBaseModel = newBaseModelFromJson(jsonString);

import 'dart:convert';

NewBaseModel newBaseModelFromJson(String str) => NewBaseModel.fromJson(json.decode(str));

String newBaseModelToJson(NewBaseModel data) => json.encode(data.toJson());

class NewBaseModel {
    bool? status;
    String? message;
    int? productId;

    NewBaseModel({
        this.status,
        this.message,
        this.productId,
    });

    factory NewBaseModel.fromJson(Map<String, dynamic> json) => NewBaseModel(
        status: json["status"],
        message: json["message"],
        productId: json["productId"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "productId": productId,
    };
}
