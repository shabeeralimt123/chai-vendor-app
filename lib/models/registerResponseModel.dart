// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  
    RegisterResponseModel({
        this.shops,
        this.status,
    });

    Shops? shops;
    bool? status;

    factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
        shops: Shops.fromJson(json["shops"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "shops": shops!.toJson(),
        "status": status,
    };
}

class Shops {

 Shops.saveUser( 
   
        this.shopname,
        this.mobile,
       
        this.address,
       );
    Shops({
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

    int? id;
    String? logo;
    String? shopname;
    String? mobile;
    String? telephone;
    String? address;
    String? contactperson;
    String? latitude;
    String?longitude;
    String?fassilicno;
    String? gst;
    int? location;
    String? status;
    dynamic createdAt;
    DateTime? updatedAt;
    String? locatio;
    Locationss? locationss;

    factory Shops.fromJson(Map<String, dynamic> json) => Shops(
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

    int? id;
    String? location;
    int? status;
    dynamic createdAt;
    dynamic updatedAt;

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
