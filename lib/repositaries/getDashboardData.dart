import 'dart:convert';
import 'dart:developer';

import 'package:chai/Exception/loginException.dart';
import 'package:chai/models/AcceptRejectModel.dart';
import 'package:chai/models/Dashboard.dart';
import 'package:chai/models/NewOrders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DashboardData {

  Future<AcceptRejectModel> acceptReject(
    String status,
    int id,
  ) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String? token = pref.getString("tokenss");
    String? b = pref.getString("idss");
    log("the token is $token");
    log("the id is $b");
    // log("194.233.65.81/chai_admin/api/editvendor?shop_id=$b&status=$status&mobile=$phone&address=$address");

    var url = Uri(
        host: '194.233.65.81',
        path: '/chai_admin/api/setcashpurchaseaccepted',
        queryParameters: {
          'purchase_id': '$id',
          'status': '$status',
        },
        scheme: 'http');

    var response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    log('REsponse =>' +
        response.toString() +
        ' status code ' +
        response.statusCode.toString());

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // log('response of ' + '  => ' + data.toString());
      return AcceptRejectModel.fromJson(data);
    } else {
      throw LoginException("Internals Server Error");
    }
  }




  Future<DashBoard> getDashboardCount() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String? token = pref.getString("tokenss");

    var url = Uri(
        host: '194.233.65.81',
        path: '/chai_admin/api/getvendorpcount',
        scheme: 'http');

    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    log('REsponse =>' +
        response.toString() +
        ' status code ' +
        response.statusCode.toString());

    if (response.statusCode == 200) {
      //   final data = json.decode(response.body) as List;
      // return data.map((e) => PendinPurchase.fromJson(e)).toList();
      final data = json.decode(response.body);

      log('response of ' '  => ' + data.toString());
      // log("return response is ${ PendinPurchase.fromJson(data)}");
      return DashBoard.fromJson(data);
    } else {
      throw LoginException("Internals Server Error");
    }
  }

   Future<NewOrders> getNewOrder(String status) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String? token = pref.getString("tokenss");

    var url = Uri(
        host: '194.233.65.81',
        path: '/chai_admin/api/getvendorpurchase/$status',
        scheme: 'http');

    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    log('REsponse =>' +
        response.toString() +
        ' status code ' +
        response.statusCode.toString());

    if (response.statusCode == 200) {
      //   final data = json.decode(response.body) as List;
      // return data.map((e) => PendinPurchase.fromJson(e)).toList();
      final data = json.decode(response.body);

      log('response of ' '  => ' + data.toString());
      // log("return response is ${ PendinPurchase.fromJson(data)}");
      return NewOrders.fromJson(data);
    } else {
      throw LoginException("Internals Server Error");
    }
  }
}
