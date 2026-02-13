// To parse this JSON data, do
//
//     final myProductModel = myProductModelFromJson(jsonString);

import 'dart:convert';

MyProductModel myProductModelFromJson(String str) => MyProductModel.fromJson(json.decode(str));

String myProductModelToJson(MyProductModel data) => json.encode(data.toJson());

class MyProductModel {
    bool? status;
    List<Datum>? data;

    MyProductModel({
        this.status,
        this.data,
    });

    factory MyProductModel.fromJson(Map<String, dynamic> json) => MyProductModel(
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
    String? barcode;
    String? title;
    String? slug;
    String? summary;
    String? photo;
    dynamic unit;
    String? stock;
    String? status;
    String? rprice;
    dynamic sprice;
    dynamic wprice;
    String? isFeatured;
    String? addedBy;
    String? catId;
    String? brandId;
    String? shopId;
    String? url;
    dynamic size;
    dynamic weight;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic variableProduct;
    String? role;
    String? subCatId;
    dynamic stockAvailable;

    Datum({
        this.id,
        this.barcode,
        this.title,
        this.slug,
        this.summary,
        this.photo,
        this.unit,
        this.stock,
        this.status,
        this.rprice,
        this.sprice,
        this.wprice,
        this.isFeatured,
        this.addedBy,
        this.catId,
        this.brandId,
        this.shopId,
        this.url,
        this.size,
        this.weight,
        this.createdAt,
        this.updatedAt,
        this.variableProduct,
        this.role,
        this.subCatId,
        this.stockAvailable,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        barcode: json["barcode"],
        title: json["title"],
        slug: json["slug"],
        summary: json["summary"],
        photo: json["photo"],
        unit: json["unit"],
        stock: json["stock"],
        status: json["status"],
        rprice: json["rprice"],
        sprice: json["sprice"],
        wprice: json["wprice"],
        isFeatured: json["is_featured"],
        addedBy: json["added_by"],
        catId: json["cat_id"],
        brandId: json["brand_id"],
        shopId: json["shop_id"],
        url: json["url"],
        size: json["size"],
        weight: json["weight"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        variableProduct: json["variable_product"],
        role: json["role"],
        subCatId: json["sub_cat_id"],
        stockAvailable: json["stockAvailable"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "barcode": barcode,
        "title": title,
        "slug": slug,
        "summary": summary,
        "photo": photo,
        "unit": unit,
        "stock": stock,
        "status": status,
        "rprice": rprice,
        "sprice": sprice,
        "wprice": wprice,
        "is_featured": isFeatured,
        "added_by": addedBy,
        "cat_id": catId,
        "brand_id": brandId,
        "shop_id": shopId,
        "url": url,
        "size": size,
        "weight": weight,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "variable_product": variableProduct,
        "role": role,
        "sub_cat_id": subCatId,
        "stockAvailable": stockAvailable,
    };
}
