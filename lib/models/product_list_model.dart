// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
    bool? status;
    Data? data;

    ProductListModel({
        this.status,
        this.data,
    });

    factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    int? currentPage;
    List<Datum>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    String? nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    Data({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
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
    dynamic shopId;
    String? url;
    dynamic size;
    dynamic weight;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic variableProduct;
    String? role;
    String? subCatId;
    dynamic stockAvailable;
    String? isAdded;

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
        this.isAdded,
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
        isAdded: json["is_added"],
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
        "is_added": isAdded,
    };
}

class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
