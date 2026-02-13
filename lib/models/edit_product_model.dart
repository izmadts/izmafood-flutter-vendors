// To parse this JSON data, do
//
//     final productEditModel = productEditModelFromJson(jsonString);

import 'dart:convert';

ProductEditModel productEditModelFromJson(String str) => ProductEditModel.fromJson(json.decode(str));

String productEditModelToJson(ProductEditModel data) => json.encode(data.toJson());

class ProductEditModel {
    bool? status;
    Data? data;

    ProductEditModel({
        this.status,
        this.data,
    });

    factory ProductEditModel.fromJson(Map<String, dynamic> json) => ProductEditModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
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
    String? sprice;
    String? wprice;
    String? isFeatured;
    String? addedBy;
    String? catId;
    String? brandId;
    dynamic shopId;
    String? url;
    dynamic size;
    dynamic weight;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? variableProduct;
    String? role;
    String? subCatId;
    String? stockAvailable;
    List<AttributePrice>? attributePrices;

    Data({
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
        this.attributePrices,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        stockAvailable: json["stockAvailable"] ?? json["stock_available"]?.toString(),
        attributePrices: json["attribute_prices"] == null ? [] : List<AttributePrice>.from(json["attribute_prices"]!.map((x) => AttributePrice.fromJson(x))),
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
        "attribute_prices": attributePrices == null ? [] : List<dynamic>.from(attributePrices!.map((x) => x.toJson())),
    };
}

class AttributePrice {
    int? id;
    String? productId;
    String? attributeId;
    String? attributeVlue;
    String? price;
    String? quantity;

    AttributePrice({
        this.id,
        this.productId,
        this.attributeId,
        this.attributeVlue,
        this.price,
        this.quantity,
    });

    factory AttributePrice.fromJson(Map<String, dynamic> json) => AttributePrice(
        id: json["id"],
        productId: json["product_id"],
        attributeId: json["attribute_id"],
        attributeVlue: json["attribute_vlue"],
        price: json["price"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "attribute_id": attributeId,
        "attribute_vlue": attributeVlue,
        "price": price,
        "quantity": quantity,
    };
}
