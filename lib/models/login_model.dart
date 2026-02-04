// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    bool? status;
    Data? data;

    LoginModel({
        this.status,
        this.data,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    String? massage;
    User? user;
    String? token;

    Data({
        this.massage,
        this.user,
        this.token,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        massage: json["massage"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "massage": massage,
        "user": user?.toJson(),
        "token": token,
    };
}

class User {
    int? id;
    String? name;
    String? mobile;
    dynamic mobileVerifiedAt;
    String? email;
    dynamic emailVerifiedAt;
    String? role;
    String? status;
    DateTime? dob;
    String? gender;
    String? working;
    dynamic onorder;
    String? numorders;
    dynamic rejectedorders;
    String? photo;
    String? lat;
    String? lng;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic stripeId;
    dynamic cardBrand;
    dynamic cardLastFour;
    dynamic trialEndsAt;
    dynamic referalLink;
    dynamic riderActive;
    dynamic address;
    dynamic mobileVerified;
    dynamic emailVerified;
    dynamic facebookId;
    dynamic googleId;
    Shop? shop;

    User({
        this.id,
        this.name,
        this.mobile,
        this.mobileVerifiedAt,
        this.email,
        this.emailVerifiedAt,
        this.role,
        this.status,
        this.dob,
        this.gender,
        this.working,
        this.onorder,
        this.numorders,
        this.rejectedorders,
        this.photo,
        this.lat,
        this.lng,
        this.createdAt,
        this.updatedAt,
        this.stripeId,
        this.cardBrand,
        this.cardLastFour,
        this.trialEndsAt,
        this.referalLink,
        this.riderActive,
        this.address,
        this.mobileVerified,
        this.emailVerified,
        this.facebookId,
        this.googleId,
        this.shop,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        mobileVerifiedAt: json["mobile_verified_at"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        role: json["role"],
        status: json["status"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        gender: json["gender"],
        working: json["working"],
        onorder: json["onorder"],
        numorders: json["numorders"],
        rejectedorders: json["rejectedorders"],
        photo: json["photo"],
        lat: json["lat"],
        lng: json["lng"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        stripeId: json["stripe_id"],
        cardBrand: json["card_brand"],
        cardLastFour: json["card_last_four"],
        trialEndsAt: json["trial_ends_at"],
        referalLink: json["referal_link"],
        riderActive: json["rider_active"],
        address: json["address"],
        mobileVerified: json["mobile_verified"],
        emailVerified: json["email_verified"],
        facebookId: json["facebook_id"],
        googleId: json["google_id"],
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "mobile_verified_at": mobileVerifiedAt,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "role": role,
        "status": status,
        "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "working": working,
        "onorder": onorder,
        "numorders": numorders,
        "rejectedorders": rejectedorders,
        "photo": photo,
        "lat": lat,
        "lng": lng,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "stripe_id": stripeId,
        "card_brand": cardBrand,
        "card_last_four": cardLastFour,
        "trial_ends_at": trialEndsAt,
        "referal_link": referalLink,
        "rider_active": riderActive,
        "address": address,
        "mobile_verified": mobileVerified,
        "email_verified": emailVerified,
        "facebook_id": facebookId,
        "google_id": googleId,
        "shop": shop?.toJson(),
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
