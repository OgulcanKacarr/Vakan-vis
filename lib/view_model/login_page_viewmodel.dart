import 'package:flutter/material.dart';
import 'package:vakanuvis/services/auth_service.dart';
import 'package:vakanuvis/themes/strings.dart';

class LoginPageViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final AllStrings _strings = AllStrings();

  void goCreatePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/createpage");
    notifyListeners();
  }

  void checkLoginInfo(BuildContext context, String email, String password) async {
    if (email.isEmpty == true) {
      _strings.showSnackBar(context, _strings.check_email);
    } else if (password.isEmpty == true) {
      _strings.showSnackBar(context, _strings.check_password);
    } else if (email.isEmpty == true && password.isEmpty == true) {
      _strings.showSnackBar(context, _strings.enter_info);
    } else {
      _strings.showProgressDialog(context);
      _authService
          .loginUserWithEmailAndPassword(context, email, password)
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
