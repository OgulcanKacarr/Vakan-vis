import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vakanuvis/services/auth_service.dart';
import 'package:vakanuvis/themes/strings.dart';

class HomePageViewmodel extends ChangeNotifier {

  final AuthService _authService = AuthService();
  final AllStrings _strings = AllStrings();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void showAlertDialog(BuildContext context) {

    String? currentUserEmail = _auth.currentUser?.email;
    bool isAdmin = currentUserEmail == "ogulcankacar5454@gmail.com";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(_strings.choose_option)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _authService.logoutUser(context);
                },
                child: Text(_strings.exit),
                style:  ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    side: BorderSide(color: Colors.green, width: 2.0), // Border color and width
                  ),
                ),
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
                  child: Text(_strings.admin),
                  style:  ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      side: BorderSide(color: Colors.blue, width: 2.0), // Border color and width
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(_strings.cancel),
            ),
          ],
        );
      },
    );
  }

}
