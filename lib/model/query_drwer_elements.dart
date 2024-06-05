import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerQueryElements extends StatelessWidget {
  const DrawerQueryElements({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Image.asset("assets/images/dragon_logo.png")),
          //Ana Sayfa
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Ana Sayfa"),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/homepage",arguments: "Ana Sayfa");
            },
          ),
          //Kişi Sorgu
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Kişi Sorgu"),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/person_page",arguments: "Kişi Sorgu");
            },
          ),
          //Aile Sorgu
          ListTile(
            leading: Icon(Icons.family_restroom),
            title: Text("Aile Sorgu"),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/family_page",arguments: "Aile Sorgu");
            },
          ),
          //Adres Sorgu
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text("Adres Sorgu"),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/address_page",arguments: "Adres Sorgu");
            },
          ),
          //Telefon Sorgu
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text("Telefon Sorgu"),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/phone_page",arguments: "Telefon Sorgu");
            },
          ),
          //Okul Sorgu
          ListTile(
            leading: Icon(Icons.school_outlined),
            title: Text("Okul Sorgu"),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/school_page",arguments: "Okul Sorgu");
            },
          ),
          //Okul Sorgu
          ListTile(
            leading: Icon(Icons.food_bank),
            title: Text("İban Sorgu"),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/iban_page",arguments: "İban Sorgu");
            },
          ),
          //İp Sorgu
          ListTile(
            leading: Icon(Icons.network_check),
            title: Text("İp Sorgu"),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/ip_page",arguments: "İp Sorgu");
            },
          ),
        ],
      ),
    );
  }
}
