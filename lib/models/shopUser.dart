// To parse this JSON data, do
//
//     final shopUser = shopUserFromJson(jsonString);

import 'dart:convert';

ShopUser shopUserFromJson(String str) => ShopUser.fromJson(json.decode(str));

String shopUserToJson(ShopUser data) => json.encode(data.toJson());

class ShopUser {
    ShopUser({
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
       
    });

    int? id;
    String? logo;
    String? shopname;
    String? mobile;
    String? telephone;
    String? address;
    String? contactperson;
    String? latitude;
    String? longitude;
    String? fassilicno;
    String? gst;
    int? location;
    int? status;
    dynamic createdAt;
    DateTime? updatedAt;
    String? locatio;
   

    factory ShopUser.fromJson(Map<String, dynamic> json) => ShopUser(
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
    
    };
}
