import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vakanuvis/services/auth_service.dart';
import 'package:vakanuvis/themes/strings.dart';

class CreatePageViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final AllStrings _strings = AllStrings();
  void goLoginPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/loginpage");
    notifyListeners();
  }

  void checkCreateInfo(BuildContext context, String email, String password, String re_password) async {
    if (email.isEmpty == true) {
      _strings.showSnackBar(context,_strings.check_email);
    } else if (password.isEmpty == true) {
      _strings.showSnackBar(context,_strings.check_password);
    }else if (re_password.isEmpty == true) {
      _strings.showSnackBar(context,_strings.user_password_retry);
    }  else if (email.isEmpty == true && password.isEmpty == true && re_password.isEmpty == true) {
      _strings.showSnackBar(context,_strings.enter_info);
    } else if (!password.contains(re_password) || !re_password.contains(password)) {
      _strings.showSnackBar(context,_strings.dont_match_password);
    }else{
      _strings.showProgressDialog(context);
      _authService.createUserWithEmailAndPassword(context,email, password)
          .then((status) {
        if (status == "succes") {
          _strings.hideProgressDialog(context);
          Navigator.pushReplacementNamed(context, "/homepage");
        } else {
          _strings.hideProgressDialog(context);
          _strings.showSnackBar(context, status);
        }
      });
    }
    notifyListeners();
  }


}
