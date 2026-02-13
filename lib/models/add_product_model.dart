// To parse this JSON data, do
//
//     final productAddedModel = productAddedModelFromJson(jsonString);

import 'dart:convert';

ProductAddedModel productAddedModelFromJson(String str) => ProductAddedModel.fromJson(json.decode(str));

String productAddedModelToJson(ProductAddedModel data) => json.encode(data.toJson());

class ProductAddedModel {
    bool? status;
    String? message;
    int? productId;
    String? errors;

    ProductAddedModel({
        this.status,
        this.message,
        this.productId,
        this.errors,
    });

    factory ProductAddedModel.fromJson(Map<String, dynamic> json) => ProductAddedModel(
        status: json["status"],
        message: json["message"],
        productId: json["productId"],
        errors: json["errors"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "productId": productId,
        "errors": errors,
    };
}
