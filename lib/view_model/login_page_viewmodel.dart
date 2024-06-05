import 'package:flutter/material.dart';
import 'package:vakanuvis/services/auth_service.dart';

class LoginPageViewModel extends ChangeNotifier{
AuthService authService = AuthService();
  void goCreatePage(BuildContext context){
    Navigator.pushReplacementNamed(context, "/createpage");
    notifyListeners();
  }

  void checkLoginInfo(BuildContext context, String email, String password) async {
    if (email.isEmpty == true) {
      showSnackBar(context,"Email boş olamaz");
    } else if (password.isEmpty == true) {
      showSnackBar(context,"Parola boş olamaz");
    } else if (email.isEmpty == true && password.isEmpty == true) {
      showSnackBar(context,"Email ve Parola boş olamaz");
    } else{
      authService.loginUserWithEmailAndPassword(context,email, password)
          .then((status) {
        if (status == "succes") {
          Navigator.pushReplacementNamed(context, "/homepage");
        } else {
          showSnackBar(context, status);
        }
      });
    }
    notifyListeners();
  }
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //Snakbar içeriği
      content: Text(message),
      //Snakbar gösterim süresi
      duration: Duration(milliseconds: 2000),
    ));
  }

}