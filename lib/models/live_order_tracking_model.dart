// To parse this JSON data, do
//
//     final liveOrderTrackingModel = liveOrderTrackingModelFromJson(jsonString);

import 'dart:convert';

LiveOrderTrackingModel liveOrderTrackingModelFromJson(String str) => LiveOrderTrackingModel.fromJson(json.decode(str));

String liveOrderTrackingModelToJson(LiveOrderTrackingModel data) => json.encode(data.toJson());

class LiveOrderTrackingModel {
    List<Cancelled>? pending;
    List<Cancelled>? confirmed;
    List<Cancelled>? delivered;
    List<Cancelled>? dispatched;
    List<Cancelled>? cancelled;

    LiveOrderTrackingModel({
        this.pending,
        this.confirmed,
        this.delivered,
        this.dispatched,
        this.cancelled,
    });

    factory LiveOrderTrackingModel.fromJson(Map<String, dynamic> json) => LiveOrderTrackingModel(
        pending: json["pending"] == null ? [] : List<Cancelled>.from(json["pending"]!.map((x) => Cancelled.fromJson(x))),
        confirmed: json["confirmed"] == null ? [] : List<Cancelled>.from(json["confirmed"]!.map((x) => Cancelled.fromJson(x))),
        delivered: json["delivered"] == null ? [] : List<Cancelled>.from(json["delivered"]!.map((x) => Cancelled.fromJson(x))),
        dispatched: json["dispatched"] == null ? [] : List<Cancelled>.from(json["dispatched"]!.map((x) => Cancelled.fromJson(x))),
        cancelled: json["cancelled"] == null ? [] : List<Cancelled>.from(json["cancelled"]!.map((x) => Cancelled.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pending": pending == null ? [] : List<dynamic>.from(pending!.map((x) => x.toJson())),
        "confirmed": confirmed == null ? [] : List<dynamic>.from(confirmed!.map((x) => x.toJson())),
        "delivered": delivered == null ? [] : List<dynamic>.from(delivered!.map((x) => x.toJson())),
        "dispatched": dispatched == null ? [] : List<dynamic>.from(dispatched!.map((x) => x.toJson())),
        "cancelled": cancelled == null ? [] : List<dynamic>.from(cancelled!.map((x) => x.toJson())),
    };
}

class Cancelled {
    int? id;
    String? shopName;
    String? lastStatus;
    String? status;
    String? lastStatusId;
    DateTime? time;
    String? client;
    String? orderStatus;
    String? link;
    String? price;
    String? pulse;

    Cancelled({
        this.id,
        this.shopName,
        this.lastStatus,
        this.status,
        this.lastStatusId,
        this.time,
        this.client,
        this.orderStatus,
        this.link,
        this.price,
        this.pulse,
    });

    factory Cancelled.fromJson(Map<String, dynamic> json) => Cancelled(
        id: json["id"],
        shopName: json["shop_name"],
        lastStatus: json["last_status"],
        status: json["status"],
        lastStatusId: json["last_status_id"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        client: json["client"],
        orderStatus: json["order_status"],
        link: json["link"],
        price: json["price"],
        pulse: json["pulse"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "shop_name": shopName,
        "last_status": lastStatus,
        "status": status,
        "last_status_id": lastStatusId,
        "time": time?.toIso8601String(),
        "client": client,
        "order_status": orderStatus,
        "link": link,
        "price": price,
        "pulse": pulse,
    };
}
