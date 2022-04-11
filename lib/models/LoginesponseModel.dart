// To parse this JSON data, do
//
//     final loginResponsemodel = loginResponsemodelFromJson(jsonString);

import 'dart:convert';

LoginResponsemodel loginResponsemodelFromJson(String str) => LoginResponsemodel.fromJson(json.decode(str));

String loginResponsemodelToJson(LoginResponsemodel data) => json.encode(data.toJson());

class LoginResponsemodel {
    LoginResponsemodel({
        this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.user,
        this.otp,
    });

    final String? accessToken;
    final String? tokenType;
    final int? expiresIn;
    final User? user;
    final String? otp;

    factory LoginResponsemodel.fromJson(Map<String, dynamic> json) => LoginResponsemodel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        user: User.fromJson(json["user"]),
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "user": user!.toJson(),
        "otp": otp,
    };
}

class User {
    User({
        this.id,
        this.logo,
        this.shopname,
        this.mobile,
        this.telephone,
        this.address,
        this.contactperson,
        this.latitude,
        this.longitude,
        this.fassilicno,
        this.gst,
        this.location,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.locatio,
        this.locationss,
    });

    final int? id;
    final String? logo;
    final String? shopname;
    final String? mobile;
    final String? telephone;
    final String? address;
    final String? contactperson;
    final String? latitude;
    final String? longitude;
    final String? fassilicno;
    final String? gst;
    final int? location;
    final int? status;
    final dynamic createdAt;
    final DateTime? updatedAt;
    final String? locatio;
    final Locationss? locationss;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        logo: json["logo"],
        shopname: json["shopname"],
        mobile: json["mobile"],
        telephone: json["telephone"],
        address: json["address"],
        contactperson: json["contactperson"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        fassilicno: json["fassilicno"],
        gst: json["gst"],
        location: json["location"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        locatio: json["locatio"],
        locationss: Locationss.fromJson(json["locationss"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "logo": logo,
        "shopname": shopname,
        "mobile": mobile,
        "telephone": telephone,
        "address": address,
        "contactperson": contactperson,
        "latitude": latitude,
        "longitude": longitude,
        "fassilicno": fassilicno,
        "gst": gst,
        "location": location,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt!.toIso8601String(),
        "locatio": locatio,
        "locationss": locationss!.toJson(),
    };
}

class Locationss {
    Locationss({
        this.id,
        this.location,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    final int? id;
    final String? location;
    final int? status;
    final dynamic createdAt;
    final dynamic updatedAt;

    factory Locationss.fromJson(Map<String, dynamic> json) => Locationss(
        id: json["id"],
        location: json["location"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
