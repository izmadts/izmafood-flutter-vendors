// To parse this JSON data, do
//
//     final attributeValueModel = attributeValueModelFromJson(jsonString);

import 'dart:convert';

AttributeValueModel attributeValueModelFromJson(String str) => AttributeValueModel.fromJson(json.decode(str));

String attributeValueModelToJson(AttributeValueModel data) => json.encode(data.toJson());

class AttributeValueModel {
    bool? status;
    List<Datum>? data;

    AttributeValueModel({
        this.status,
        this.data,
    });

    factory AttributeValueModel.fromJson(Map<String, dynamic> json) => AttributeValueModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? productAttribute;
    String? comment;
    String? status;
    DateTime? createDate;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.productAttribute,
        this.comment,
        this.status,
        this.createDate,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productAttribute: json["product_attribute"],
        comment: json["comment"],
        status: json["status"],
        createDate: json["create_date"] == null ? null : DateTime.parse(json["create_date"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_attribute": productAttribute,
        "comment": comment,
        "status": status,
        "create_date": createDate?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
