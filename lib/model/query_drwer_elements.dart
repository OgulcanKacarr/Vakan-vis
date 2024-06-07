import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vakanuvis/themes/strings.dart';

class DrawerQueryElements extends StatelessWidget {
  DrawerQueryElements({super.key});
  AllStrings _strings = AllStrings();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Column(children: [
            Image.asset(_strings.logo),
          ],)),
          //Ana Sayfa
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(_strings.home),
            trailing: const Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/homepage",arguments: "Ana Sayfa");
            },
          ),

          //Full Sorgu
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(_strings.full_query),
            trailing: const Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/full_page",arguments: "Full Sorgu");
            },
          ),
          //Kişi Sorgu
          ListTile(
            leading: Icon(Icons.person),
            title: Text(_strings.person_query),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/person_page",arguments: "Kişi Sorgu");
            },
          ),
          //Aile Sorgu
          ListTile(
            leading: Icon(Icons.family_restroom),
            title: Text(_strings.family_query),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/family_page",arguments: "Aile Sorgu");
            },
          ),
          //Adres Sorgu
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text(_strings.address_query),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/address_page",arguments: "Adres Sorgu");
            },
          ),
          //Telefon Sorgu
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text(_strings.phone_query),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/phone_page",arguments: "Telefon Sorgu");
            },
          ),
          //Okul Sorgu
          ListTile(
            leading: Icon(Icons.school_outlined),
            title: Text(_strings.school_query),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/school_page",arguments: "Okul Sorgu");
            },
          ),
          //Okul Sorgu
          ListTile(
            leading: Icon(Icons.food_bank),
            title: Text(_strings.iban_query),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.pushNamed(context, "/iban_page",arguments: "İban Sorgu");
            },
          ),
          //İp Sorgu
          ListTile(
            leading: Icon(Icons.network_check),
            title: Text(_strings.ip_query),
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
