// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    Data? data;

    LoginModel({
        this.data,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
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
    String? onorder;
    String? numorders;
    dynamic rejectedorders;
    String? photo;
    dynamic lat;
    dynamic lng;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic stripeId;
    dynamic cardBrand;
    dynamic cardLastFour;
    dynamic trialEndsAt;
    String? referalLink;
    dynamic riderActive;
    dynamic address;
    dynamic mobileVerified;
    dynamic emailVerified;
    dynamic facebookId;
    dynamic googleId;
    dynamic shop;

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
        shop: json["shop"],
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
        "shop": shop,
    };
}
