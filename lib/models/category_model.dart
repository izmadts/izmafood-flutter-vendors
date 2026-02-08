// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    String? status;
    List<SubCategory>? subCategory;

    CategoryModel({
        this.status,
        this.subCategory,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        status: json["status"],
        subCategory: json["sub_category"] == null ? [] : List<SubCategory>.from(json["sub_category"]!.map((x) => SubCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "sub_category": subCategory == null ? [] : List<dynamic>.from(subCategory!.map((x) => x.toJson())),
    };
}

class SubCategory {
    int? id;
    String? title;
    String? slug;
    dynamic summary;
    dynamic bgcolor;
    dynamic photo;
    String? isParent;
    String? parentId;
    String? ishomeShow;
    String? addedBy;
    String? status;
    dynamic createdAt;
    dynamic updatedAt;

    SubCategory({
        this.id,
        this.title,
        this.slug,
        this.summary,
        this.bgcolor,
        this.photo,
        this.isParent,
        this.parentId,
        this.ishomeShow,
        this.addedBy,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        summary: json["summary"],
        bgcolor: json["bgcolor"],
        photo: json["photo"],
        isParent: json["is_parent"],
        parentId: json["parent_id"],
        ishomeShow: json["ishome_show"],
        addedBy: json["added_by"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "summary": summary,
        "bgcolor": bgcolor,
        "photo": photo,
        "is_parent": isParent,
        "parent_id": parentId,
        "ishome_show": ishomeShow,
        "added_by": addedBy,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
