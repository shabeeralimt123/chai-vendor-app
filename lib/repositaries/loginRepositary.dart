import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:chai/Exception/loginException.dart';
import 'package:chai/models/LoginesponseModel.dart';
import 'package:chai/models/registerResponseModel.dart';
import 'package:chai/models/shopUser.dart';
import 'package:chai/resources/prefResources.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String constToken =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTk0LjIzMy42NS44MS9jaGFpX2FkbWluL2FwaS9sb2dpbnZlbmRvciIsImlhdCI6MTY0Nzk0NTAwMywibmJmIjoxNjQ3OTQ1MDAzLCJqdGkiOiJqak9NMFh3QzROR3BWYlhjIiwic3ViIjoyLCJwcnYiOiJhYTUxYmEwMjQwNWE5MzJjOTQ0NTNkYWY1MDBmZGI5YjhhOWM2ZDAwIn0.MV6Ye2cbX3B3ib6o-fbL_6FRdKDp8MVV_In2fcDSUjs";

class AuthenticationRepository {
  Future<LoginResponsemodel> login(String phone) async {
    final String urlPath = "/chai_admin/api/loginvendor";

    String host = "194.233.65.81";

    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final httpClient = IOClient(ioc);

    http.Response response = await httpClient.post(
      Uri(
        path: urlPath,
        host: host,
        scheme: 'https',
        queryParameters: {'mobile': phone},
      ),
    );

    log('REsponse =>' +
        response.toString() +
        ' status code ' +
        response.statusCode.toString());

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      String token = json.decode(response.body)['access_token'];
      var ids = json.decode(response.body)['user']['id'];

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('tokenss', token);
      prefs.setString('idss', ids.toString());

      log(".................$token");

      log("id is ehdhhdhf ...........$ids");

      log('response of ' + '  => ' + data.toString());
      return LoginResponsemodel.fromJson(data);
    } else {
      throw LoginException("Internal Server Error");
    }
  }

  Future<RegisterResponseModel> register(
     String shopname,
   
    
    String phone,
    String address,
     int status,
  ) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String? token = pref.getString("tokenss");
    String? b = pref.getString("idss");
    log("the token is $token");
    log("the id is $b");
    log("194.233.65.81/chai_admin/api/editvendor?shop_id=$b&status=$status&mobile=$phone&address=$address");

    var url = Uri(
        host: '194.233.65.81',
        path: '/chai_admin/api/editvendor',
        queryParameters: {
          'shop_id': '$b',
          'shopname':'$shopname',
          'status': '$status',
          'mobile': '$phone',
          'address': '$address',
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

      log('response of the register ' + '  => ' + data.toString());
      return RegisterResponseModel.fromJson(data);
    } else {
      throw LoginException("Internals Server Error");
    }
  }
    Future<ShopUser> getShopUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String? token = pref.getString("tokenss");
  
    log("the token is $token");
   
   

    var url = Uri(
        host: '194.233.65.81',
        path: '/chai_admin/api/vendoruser',
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
      return ShopUser.fromJson(data);
    } else {
      throw LoginException("Internals Server Error");
    }
  }


}
