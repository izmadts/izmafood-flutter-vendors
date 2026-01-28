// To parse this JSON data, do
//
//     final mainModel = mainModelFromJson(jsonString);

import 'dart:convert';

MainModel mainModelFromJson(String str) => MainModel.fromJson(json.decode(str));

String mainModelToJson(MainModel data) => json.encode(data.toJson());

class MainModel {
  String? status;

  List<Category>? mainCategory;

  MainModel({
    this.status,
    this.mainCategory,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) => MainModel(
        status: json["status"],
        mainCategory: json["main_category"] == null
            ? []
            : List<Category>.from(
                json["main_category"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "main_category": mainCategory == null
            ? []
            : List<dynamic>.from(mainCategory!.map((x) => x.toJson())),
      };
}

class Category {
  int? id;
  String? title;
  String? slug;
  String? summary;
  dynamic bgcolor;
  String? photo;
  String? isParent;
  String? parentId;
  String? ishomeShow;
  String? addedBy;
  String? status;
  dynamic createdAt;
  DateTime? updatedAt;

  Category({
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        "updated_at": updatedAt?.toIso8601String(),
      };
}
