// To parse this JSON data, do
//
//     final newOrders = newOrdersFromJson(jsonString);

import 'dart:convert';

NewOrders newOrdersFromJson(String str) => NewOrders.fromJson(json.decode(str));

String newOrdersToJson(NewOrders data) => json.encode(data.toJson());

class NewOrders {
    NewOrders({
        this.purchaseorders,
    });

    Purchaseorders? purchaseorders;

    factory NewOrders.fromJson(Map<String, dynamic> json) => NewOrders(
        purchaseorders: Purchaseorders.fromJson(json["purchaseorders"]),
    );

    Map<String, dynamic> toJson() => {
        "purchaseorders": purchaseorders!.toJson(),
    };
}

class Purchaseorders {
    Purchaseorders({
        this.total,
        this.purchase,
    });

    int? total;
    List<Purchase>? purchase;

    factory Purchaseorders.fromJson(Map<String, dynamic> json) => Purchaseorders(
        total: json["total"],
        purchase: List<Purchase>.from(json["purchase"].map((x) => Purchase.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "purchase": List<dynamic>.from(purchase!.map((x) => x.toJson())),
    };
}

class Purchase {
    Purchase({
        this.id,
        this.customername,
        this.amount,
        this.date,
        this.time,
    });

    int? id;
    String? customername;
    String? amount;
   String? date;
    String? time;

    factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
        id: json["id"],
        customername: json["customername"],
        amount: json["amount"],
        date:json["date"],
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customername": customername,
        "amount": amount,
        "date": date,
        "time": time,
    };
}
