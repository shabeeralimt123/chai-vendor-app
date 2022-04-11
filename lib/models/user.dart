// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
    Users({
      required  this.name,
       required this.phone,
     required   this.address,
     required this.swichControll,
     required this.textHolder

    });

   String name;
    String phone;
    String address;
    bool swichControll;
    String textHolder;

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        swichControll:json["swichControll"],
        textHolder: json["textHolder"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "address": address,
        "swichControll":swichControll,
        "textHolder":textHolder,
    };
}
