import 'package:flutter/material.dart';

class LoginPageViewModel extends ChangeNotifier{

  void goCreatePage(BuildContext context){
    Navigator.pushReplacementNamed(context, "/createpage");
    notifyListeners();
  }

}