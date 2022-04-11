// To parse this JSON data, do
//
//     final acceptRejectModel = acceptRejectModelFromJson(jsonString);

import 'dart:convert';

AcceptRejectModel acceptRejectModelFromJson(String str) => AcceptRejectModel.fromJson(json.decode(str));

String acceptRejectModelToJson(AcceptRejectModel data) => json.encode(data.toJson());

class AcceptRejectModel {
    AcceptRejectModel({
        this.status,
        this.message,
    });

    int? status;
    String? message;

    factory AcceptRejectModel.fromJson(Map<String, dynamic> json) => AcceptRejectModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
