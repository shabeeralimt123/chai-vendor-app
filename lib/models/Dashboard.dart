// To parse this JSON data, do
//
//     final dashBoard = dashBoardFromJson(jsonString);

import 'dart:convert';

DashBoard dashBoardFromJson(String str) => DashBoard.fromJson(json.decode(str));

String dashBoardToJson(DashBoard data) => json.encode(data.toJson());

class DashBoard {
    DashBoard({
        this.pendingpurchase,
        this.cashpurchase,
        this.order,
        this.total,
    });

    int? pendingpurchase;
    int? cashpurchase;
    int? order;
    int? total;

    factory DashBoard.fromJson(Map<String, dynamic> json) => DashBoard(
        pendingpurchase: json["pendingpurchase"],
        cashpurchase: json["cashpurchase"],
        order: json["order"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "pendingpurchase": pendingpurchase,
        "cashpurchase": cashpurchase,
        "order": order,
        "total": total,
    };
}
