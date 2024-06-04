import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/ThemeClass.dart';
import 'package:vakanuvis/view/create_page.dart';
import 'package:vakanuvis/view/login_page.dart';
import 'package:vakanuvis/view/splash_page.dart';

void main() {
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
      },
    );
  }
}
