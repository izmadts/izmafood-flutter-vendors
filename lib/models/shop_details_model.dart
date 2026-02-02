// To parse this JSON data, do
//
//     final shopDetailsModel = shopDetailsModelFromJson(jsonString);

import 'dart:convert';

ShopDetailsModel shopDetailsModelFromJson(String str) => ShopDetailsModel.fromJson(json.decode(str));

String shopDetailsModelToJson(ShopDetailsModel data) => json.encode(data.toJson());

class ShopDetailsModel {
    bool? status;
    Shop? shop;
    List<BusinessHour>? businessHours;

    ShopDetailsModel({
        this.status,
        this.shop,
        this.businessHours,
    });

    factory ShopDetailsModel.fromJson(Map<String, dynamic> json) => ShopDetailsModel(
        status: json["status"],
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
        businessHours: json["business_hours"] == null ? [] : List<BusinessHour>.from(json["business_hours"]!.map((x) => BusinessHour.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "shop": shop?.toJson(),
        "business_hours": businessHours == null ? [] : List<dynamic>.from(businessHours!.map((x) => x.toJson())),
    };
}

class BusinessHour {
    String? type;
    String? dayOfWeek;
    String? opens;
    String? closes;

    BusinessHour({
        this.type,
        this.dayOfWeek,
        this.opens,
        this.closes,
    });

    factory BusinessHour.fromJson(Map<String, dynamic> json) => BusinessHour(
        type: json["@type"],
        dayOfWeek: json["dayOfWeek"],
        opens: json["opens"],
        closes: json["closes"],
    );

    Map<String, dynamic> toJson() => {
        "@type": type,
        "dayOfWeek": dayOfWeek,
        "opens": opens,
        "closes": closes,
    };
}

class Shop {
    int? id;
    String? shopName;
    String? slug;
    String? ipaddress;
    String? radius;
    String? lat;
    String? lng;
    dynamic faddress;
    dynamic cnic;
    dynamic expiry;
    dynamic licence;
    dynamic ntn;
    String? shopType;
    String? shopCategory;
    String? logo;
    String? banner;
    String? fcnic;
    String? bcnic;
    dynamic licencePhoto;
    dynamic ntnPhoto;
    String? deliveryTime;
    String? status;
    String? isOpen;
    String? owner;
    dynamic accountName;
    dynamic accountTitle;
    dynamic accountNumber;
    DateTime? createdAt;
    DateTime? updatedAt;

    Shop({
        this.id,
        this.shopName,
        this.slug,
        this.ipaddress,
        this.radius,
        this.lat,
        this.lng,
        this.faddress,
        this.cnic,
        this.expiry,
        this.licence,
        this.ntn,
        this.shopType,
        this.shopCategory,
        this.logo,
        this.banner,
        this.fcnic,
        this.bcnic,
        this.licencePhoto,
        this.ntnPhoto,
        this.deliveryTime,
        this.status,
        this.isOpen,
        this.owner,
        this.accountName,
        this.accountTitle,
        this.accountNumber,
        this.createdAt,
        this.updatedAt,
    });

    factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        shopName: json["shop_name"],
        slug: json["slug"],
        ipaddress: json["ipaddress"],
        radius: json["radius"],
        lat: json["lat"],
        lng: json["lng"],
        faddress: json["faddress"],
        cnic: json["cnic"],
        expiry: json["expiry"],
        licence: json["licence"],
        ntn: json["ntn"],
        shopType: json["shop_type"],
        shopCategory: json["shop_category"],
        logo: json["logo"],
        banner: json["banner"],
        fcnic: json["fcnic"],
        bcnic: json["bcnic"],
        licencePhoto: json["licence_photo"],
        ntnPhoto: json["ntn_photo"],
        deliveryTime: json["delivery_time"],
        status: json["status"],
        isOpen: json["is_open"],
        owner: json["owner"],
        accountName: json["account_name"],
        accountTitle: json["account_title"],
        accountNumber: json["account_number"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "shop_name": shopName,
        "slug": slug,
        "ipaddress": ipaddress,
        "radius": radius,
        "lat": lat,
        "lng": lng,
        "faddress": faddress,
        "cnic": cnic,
        "expiry": expiry,
        "licence": licence,
        "ntn": ntn,
        "shop_type": shopType,
        "shop_category": shopCategory,
        "logo": logo,
        "banner": banner,
        "fcnic": fcnic,
        "bcnic": bcnic,
        "licence_photo": licencePhoto,
        "ntn_photo": ntnPhoto,
        "delivery_time": deliveryTime,
        "status": status,
        "is_open": isOpen,
        "owner": owner,
        "account_name": accountName,
        "account_title": accountTitle,
        "account_number": accountNumber,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
