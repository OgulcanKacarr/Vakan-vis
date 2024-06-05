import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidgets extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isCenter;
  final bool isBack;
  @override
  final Size preferredSize;

  CustomAppBarWidgets({
    required this.title,
    this.isCenter = false,
    this.isBack = false,
    this.preferredSize = const Size.fromHeight(56.0),
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.tealAccent),
      ),
      centerTitle: isCenter,
      backgroundColor: Colors.black,
      automaticallyImplyLeading: isBack,
      iconTheme: IconThemeData(
        color: Colors.green,
      ),
    );
  }
}
