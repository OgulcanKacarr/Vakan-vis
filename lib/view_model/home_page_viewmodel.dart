import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vakanuvis/services/auth_service.dart';

class HomePageViewmodel extends ChangeNotifier {

  AuthService authService = AuthService();
  FirebaseAuth _auth = FirebaseAuth.instance;



  void showAlertDialog(BuildContext context) {

    String? currentUserEmail = _auth.currentUser?.email;
    bool isAdmin = currentUserEmail == "ogulcankacar5454@gmail.com";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text("İşlem seç")),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  authService.logoutUser(context);
                },
                child: Text("Çıkış yap"),
              ),
              Visibility(
                visible: isAdmin,
                child: ElevatedButton(
                  onPressed: () {
                    if(isAdmin){
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/adminpage");
                    }
                  },
                  child: Text("Admin"),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("İptal"),
            ),
          ],
        );
      },
    );
  }

}
