import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;


  //Kullanıcı oluştur
  Future<String> createUserWithEmailAndPassword(BuildContext context, String email, String password) async{
    showProgressDialog(context);
    String status;
    if(email.isEmpty == true){
      status = "Email boş olamaz";
    }else if(password.isEmpty == true){
      status = "Parola boş olamaz";
    }else if(email.isEmpty == true && password.isEmpty == true){
      status = "Email ve Parola boş olamaz";
    }else{
      try{
        var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        status = "succes";

      }on FirebaseAuthException catch (error) {
        if(error.code == "email-already-in-use"){
          status = "Böyle bir email zaten var";
        }else if(error.code == "invalid-email"){
          status = "Geçerli bir email değil";
        }else if(error.code == "operation-not-allowed"){
          status = "Sistemden kaynaklı bir hata oluştur";
        }else if(error.code == "weak-password"){
          status = "Şifre yeterince güçlü değil";
        }else{
          status = error.message.toString();
        }
      }
    }
    notifyListeners();
    Navigator.pop(context);
    return status;

  }

  //Giriş yap
  Future<String> loginUserWithEmailAndPassword(BuildContext context, String email, String password) async{
    showProgressDialog(context);
    String status;
    if(email.isEmpty == true){
      status = "Email boş olamaz";
    }else if(password.isEmpty == true){
      status = "Parola boş olamaz";
    }else if(email.isEmpty == true && password.isEmpty == true){
      status = "Email ve Parola boş olamaz";
    }else{
      try{
        var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        status = "succes";

      }on FirebaseAuthException catch (error) {
        if(error.code == "account-exists-with-different-credential"){
          status = "Böyle bir email zaten var";
        }else if(error.code == "invalid-credential"){
          status = "Bilgiler uyuşmuyor";
        }else if(error.code == "operation-not-allowed"){
          status = "Sistemden kaynaklı bir hata oluştur";
        }else if(error.code == "user-disabled"){
          status = "Engellenen kullanıcı";
        } else if(error.code == "user-not-found"){
          status = "Kullanıcı bulunamadı";
        }else if(error.code == "wrong-password"){
          status = "Hatalı şifre";
        }else{
          status = error.message.toString();
        }
      }
    }
    notifyListeners();
    Navigator.pop(context);
    return status;

  }

  //Kullanıcı giriş kontrolü
  Future<bool> checkCurrentUser() async{
    bool isOnline = false;
    User? current_user = await _auth.currentUser;
    if(current_user != null){
      isOnline = true;
    }else{
      isOnline = false;
    }
    return isOnline;
  }


  void logoutUser(BuildContext context) {
    _auth.signOut().then((value) {
      showProgressDialog(context);
      Navigator.pushReplacementNamed(context, "/loginpage");
    }).catchError((error) {

    });
  }




  void showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Kullanıcı arka plana tıklamasını engeller
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(), // Dairesel ilerleme göstergesi
        );
      },
    );
  }


}