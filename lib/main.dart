import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/ThemeClass.dart';
import 'package:vakanuvis/view/create_page.dart';
import 'package:vakanuvis/view/home_page.dart';
import 'package:vakanuvis/view/login_page.dart';
import 'package:vakanuvis/view/splash_page.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print("Firebase initialization error: $e");
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
      },
    );
  }
}
