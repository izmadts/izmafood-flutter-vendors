// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) => OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) => json.encode(data.toJson());

class OrderDetailModel {
    bool? status;
    Data? data;

    OrderDetailModel({
        this.status,
        this.data,
    });

    factory OrderDetailModel.fromJson(Map<String, dynamic> json) => OrderDetailModel(
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
    DateTime? createdAt;
    DateTime? updatedAt;
    String? orderStatus;
    String? name;
    String? email;
    String? locationId;
    String? addressId;
    String? clientId;
    String? shopId;
    String? driverId;
    String? deliveryPrice;
    String? orderPrice;
    dynamic totaluserwillpay;
    String? paymentMethod;
    String? paymentStatus;
    String? comment;
    String? lat;
    String? lng;
    String? fee;
    String? feeValue;
    String? staticFee;
    String? timeToDeliver;
    String? phone;
    String? whatsappAddress;
    String? shopLat;
    String? shopLong;
    String? handleFee;
    String? deliveryCommesion;
    String? sellerCommesion;
    dynamic izmacommision;
    String? driverOrderCommision;
    String? izmaPaid;
    String? ppStatus;
    dynamic ppTxnRefNo;
    dynamic ppSecureHash;
    dynamic ppNumber;
    dynamic ppTxnType;
    dynamic cancelReason;
    dynamic responseMessege;
    String? timeFormated;
    List<LastStatus>? lastStatus;
    bool? isPrepared;
    dynamic actions;
    Client? client;
    Rider? rider;
    List<Product>? products;
    Shop? shop;
    Address? address;

    Data({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.orderStatus,
        this.name,
        this.email,
        this.locationId,
        this.addressId,
        this.clientId,
        this.shopId,
        this.driverId,
        this.deliveryPrice,
        this.orderPrice,
        this.totaluserwillpay,
        this.paymentMethod,
        this.paymentStatus,
        this.comment,
        this.lat,
        this.lng,
        this.fee,
        this.feeValue,
        this.staticFee,
        this.timeToDeliver,
        this.phone,
        this.whatsappAddress,
        this.shopLat,
        this.shopLong,
        this.handleFee,
        this.deliveryCommesion,
        this.sellerCommesion,
        this.izmacommision,
        this.driverOrderCommision,
        this.izmaPaid,
        this.ppStatus,
        this.ppTxnRefNo,
        this.ppSecureHash,
        this.ppNumber,
        this.ppTxnType,
        this.cancelReason,
        this.responseMessege,
        this.timeFormated,
        this.lastStatus,
        this.isPrepared,
        this.actions,
        this.client,
        this.rider,
        this.products,
        this.shop,
        this.address,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        orderStatus: json["order_status"],
        name: json["name"],
        email: json["email"],
        locationId: json["location_id"],
        addressId: json["address_id"],
        clientId: json["client_id"],
        shopId: json["shop_id"],
        driverId: json["driver_id"],
        deliveryPrice: json["delivery_price"],
        orderPrice: json["order_price"],
        totaluserwillpay: json["totaluserwillpay"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        comment: json["comment"],
        lat: json["lat"],
        lng: json["lng"],
        fee: json["fee"],
        feeValue: json["fee_value"],
        staticFee: json["static_fee"],
        timeToDeliver: json["time_to_deliver"],
        phone: json["phone"],
        whatsappAddress: json["whatsapp_address"],
        shopLat: json["shop_lat"],
        shopLong: json["shop_long"],
        handleFee: json["handle_fee"],
        deliveryCommesion: json["delivery_commesion"],
        sellerCommesion: json["seller_commesion"],
        izmacommision: json["izmacommision"],
        driverOrderCommision: json["driver_order_commision"],
        izmaPaid: json["izma_paid"],
        ppStatus: json["pp_status"],
        ppTxnRefNo: json["pp_TxnRefNo"],
        ppSecureHash: json["pp_SecureHash"],
        ppNumber: json["pp_number"],
        ppTxnType: json["pp_TxnType"],
        cancelReason: json["cancel_reason"],
        responseMessege: json["response_messege"],
        timeFormated: json["time_formated"],
        lastStatus: json["last_status"] == null ? [] : List<LastStatus>.from(json["last_status"]!.map((x) => LastStatus.fromJson(x))),
        isPrepared: json["is_prepared"],
        actions: json["actions"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        rider: json["rider"] == null ? null : Rider.fromJson(json["rider"]),
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "order_status": orderStatus,
        "name": name,
        "email": email,
        "location_id": locationId,
        "address_id": addressId,
        "client_id": clientId,
        "shop_id": shopId,
        "driver_id": driverId,
        "delivery_price": deliveryPrice,
        "order_price": orderPrice,
        "totaluserwillpay": totaluserwillpay,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "comment": comment,
        "lat": lat,
        "lng": lng,
        "fee": fee,
        "fee_value": feeValue,
        "static_fee": staticFee,
        "time_to_deliver": timeToDeliver,
        "phone": phone,
        "whatsapp_address": whatsappAddress,
        "shop_lat": shopLat,
        "shop_long": shopLong,
        "handle_fee": handleFee,
        "delivery_commesion": deliveryCommesion,
        "seller_commesion": sellerCommesion,
        "izmacommision": izmacommision,
        "driver_order_commision": driverOrderCommision,
        "izma_paid": izmaPaid,
        "pp_status": ppStatus,
        "pp_TxnRefNo": ppTxnRefNo,
        "pp_SecureHash": ppSecureHash,
        "pp_number": ppNumber,
        "pp_TxnType": ppTxnType,
        "cancel_reason": cancelReason,
        "response_messege": responseMessege,
        "time_formated": timeFormated,
        "last_status": lastStatus == null ? [] : List<dynamic>.from(lastStatus!.map((x) => x.toJson())),
        "is_prepared": isPrepared,
        "actions": actions,
        "client": client?.toJson(),
        "rider": rider?.toJson(),
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "shop": shop?.toJson(),
        "address": address?.toJson(),
    };
}

class Address {
    int? id;
    String? address;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? lat;
    String? lng;
    String? active;
    String? userId;
    String? apartment;
    String? floor;

    Address({
        this.id,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.lat,
        this.lng,
        this.active,
        this.userId,
        this.apartment,
        this.floor,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        address: json["address"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        lat: json["lat"],
        lng: json["lng"],
        active: json["active"],
        userId: json["user_id"],
        apartment: json["apartment"],
        floor: json["floor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "lat": lat,
        "lng": lng,
        "active": active,
        "user_id": userId,
        "apartment": apartment,
        "floor": floor,
    };
}

class Client {
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
    String? lat;
    String? lng;
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
    String? fcmToken;

    Client({
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
        this.fcmToken,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
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
        fcmToken: json["fcm_token"],
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
        "fcm_token": fcmToken,
    };
}


class Rider {
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
    String? lat;
    String? lng;
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
    String? fcmToken;

    Rider({
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
        this.fcmToken,
    });

    factory Rider.fromJson(Map<String, dynamic> json) => Rider(
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
        fcmToken: json["fcm_token"],
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
        "fcm_token": fcmToken,
    };
}


class LastStatus {
    int? id;
    String? name;
    String? alias;
    LastStatusPivot? pivot;

    LastStatus({
        this.id,
        this.name,
        this.alias,
        this.pivot,
    });

    factory LastStatus.fromJson(Map<String, dynamic> json) => LastStatus(
        id: json["id"],
        name: json["name"],
        alias: json["alias"],
        pivot: json["pivot"] == null ? null : LastStatusPivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alias": alias,
        "pivot": pivot?.toJson(),
    };
}

class LastStatusPivot {
    String? orderId;
    String? statusId;
    String? userId;
    dynamic createdAt;
    String? comment;

    LastStatusPivot({
        this.orderId,
        this.statusId,
        this.userId,
        this.createdAt,
        this.comment,
    });

    factory LastStatusPivot.fromJson(Map<String, dynamic> json) => LastStatusPivot(
        orderId: json["order_id"],
        statusId: json["status_id"],
        userId: json["user_id"],
        createdAt: json["created_at"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "status_id": statusId,
        "user_id": userId,
        "created_at": createdAt,
        "comment": comment,
    };
}

class Product {
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
    ProductPivot? pivot;

    Product({
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
        this.pivot,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        pivot: json["pivot"] == null ? null : ProductPivot.fromJson(json["pivot"]),
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
        "pivot": pivot?.toJson(),
    };
}

class ProductPivot {
    String? orderId;
    String? productId;
    String? qty;
    String? variantPrice;
    String? variantName;
    String? productAttributeId;

    ProductPivot({
        this.orderId,
        this.productId,
        this.qty,
        this.variantPrice,
        this.variantName,
        this.productAttributeId,
    });

    factory ProductPivot.fromJson(Map<String, dynamic> json) => ProductPivot(
        orderId: json["order_id"],
        productId: json["product_id"],
        qty: json["qty"],
        variantPrice: json["variant_price"],
        variantName: json["variant_name"],
        productAttributeId: json["product_attribute_id"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "product_id": productId,
        "qty": qty,
        "variant_price": variantPrice,
        "variant_name": variantName,
        "product_attribute_id": productAttributeId,
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
    String? faddress;
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
    String? accountName;
    String? accountTitle;
    String? accountNumber;
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
