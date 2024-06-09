import 'package:flutter/material.dart';

class CustomCardWidgets extends StatelessWidget {
  Widget child;

  CustomCardWidgets({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        side: BorderSide(color: Colors.purple, width: 3),
      ),
      elevation: 60,
      shadowColor: Colors.purple,
      child: child,
    );
  }
}
