// To parse this JSON data, do
//
//     final attributeModel = attributeModelFromJson(jsonString);

import 'dart:convert';

AttributeModel attributeModelFromJson(String str) => AttributeModel.fromJson(json.decode(str));

String attributeModelToJson(AttributeModel data) => json.encode(data.toJson());

class AttributeModel {
    bool? status;
    List<Datum>? data;

    AttributeModel({
        this.status,
        this.data,
    });

    factory AttributeModel.fromJson(Map<String, dynamic> json) => AttributeModel(
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
    String? attributeTitle;
    String? sellerId;
    String? status;
    DateTime? createDate;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.attributeTitle,
        this.sellerId,
        this.status,
        this.createDate,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        attributeTitle: json["attribute_title"],
        sellerId: json["seller_id"],
        status: json["status"],
        createDate: json["create_date"] == null ? null : DateTime.parse(json["create_date"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attribute_title": attributeTitle,
        "seller_id": sellerId,
        "status": status,
        "create_date": createDate?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
