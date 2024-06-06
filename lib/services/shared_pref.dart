import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{


  void save(BuildContext context,String text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //Kullanıcı adını kaydet
    await preferences.setString("host",text);
  }

  Future<String?> read(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }


}