import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/ThemeClass.dart';
import 'package:vakanuvis/view/address_query_page.dart';
import 'package:vakanuvis/view/admin_page.dart';
import 'package:vakanuvis/view/create_page.dart';
import 'package:vakanuvis/view/family_query_page.dart';
import 'package:vakanuvis/view/full_query_page.dart';
import 'package:vakanuvis/view/home_page.dart';
import 'package:vakanuvis/view/iban_query_page.dart';
import 'package:vakanuvis/view/ip_query_page.dart';
import 'package:vakanuvis/view/login_page.dart';
import 'package:vakanuvis/view/person_query_page.dart';
import 'package:vakanuvis/view/phone_query_page.dart';
import 'package:vakanuvis/view/school_no_query_page.dart';
import 'package:vakanuvis/view/splash_page.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    } catch (e) {
      print("Firebase initialization error: $e");
    }
  }
  runApp(const ProviderScope(child: MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routes: {
        "/loginpage": (context) =>  LoginPage(),
        "/createpage": (context) =>  CreatePage(),
        "/homepage": (context) =>  HomePage(),
        "/full_page": (context) =>  FullQueryPage(),
        "/adminpage": (context) =>  AdminPage(),
        "/person_page": (context) =>  PersonQueryPage(),
        "/family_page": (context) =>  FamilyQueryPage(),
        "/phone_page": (context) =>  PhonesQueryPage(),
        "/address_page": (context) =>  AddressQueryPage(),
        "/school_page": (context) =>  SchoolNoQueryPage(),
        "/iban_page": (context) =>  IbanQueryPage(),
        "/ip_page": (context) =>  IpQueryPage(),
      },
    );
  }
}
