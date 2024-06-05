import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vakanuvis/services/auth_service.dart';

class CreatePageViewModel extends ChangeNotifier {
  AuthService authService = AuthService();
  void goLoginPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/loginpage");
    notifyListeners();
  }

  void checkCreateInfo(BuildContext context, String email, String password, String re_password) async {
    if (email.isEmpty == true) {
      showSnackBar(context,"Email boş olamaz");
    } else if (password.isEmpty == true) {
      showSnackBar(context,"Parola boş olamaz");
    }else if (re_password.isEmpty == true) {
      showSnackBar(context,"Parolayı yeniden gir");
    }  else if (email.isEmpty == true && password.isEmpty == true && re_password.isEmpty == true) {
      showSnackBar(context,"Email ve Parola boş olamaz");
    } else if (!password.contains(re_password) || !re_password.contains(password)) {
      showSnackBar(context,"Parolalar uyuşmuyor");
    }else{
      authService.createUserWithEmailAndPassword(context,email, password)
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
