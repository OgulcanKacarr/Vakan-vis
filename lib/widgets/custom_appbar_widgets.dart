import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../themes/strings.dart';

class CustomAppBarWidgets extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isCenter;
  final bool isBack;
  @override
  final Size preferredSize;
  final PreferredSizeWidget? bottom; // PreferredSizeWidget türünde güncellendi
  AllStrings strings = AllStrings();

  CustomAppBarWidgets({
    required this.title,
    this.isCenter = false,
    this.isBack = false,
    this.preferredSize = const Size.fromHeight(kToolbarHeight), // kToolbarHeight kullanıldı
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.tealAccent),
      ),
      centerTitle: isCenter,
      backgroundColor: Colors.black,
      automaticallyImplyLeading: isBack,
      bottom: bottom,
      iconTheme: const IconThemeData(
        color: Colors.green,
      ),
    );
  }
}
