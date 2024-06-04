import 'package:flutter/cupertino.dart';

class CreatePageViewModel extends ChangeNotifier {

  void goLoginPage(BuildContext context){
    Navigator.pushReplacementNamed(context, "/loginpage");
    notifyListeners();
  }
}