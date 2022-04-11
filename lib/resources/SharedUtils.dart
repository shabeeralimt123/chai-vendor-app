import 'package:chai/models/registerResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils{
   static void updateUserData(Shops model) async {
    
   
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', model.shopname!);
    await prefs.setString('mobile',model.mobile!);
     await prefs.setString('address',model.address!);

  }
  static Future<Shops> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('user_name') ?? '';
    String phone = prefs.getString('mobile')??'';
    String address = prefs.getString('address')??'';


   Shops model =Shops.saveUser(
        username,phone, address);
    return model;
  }
}