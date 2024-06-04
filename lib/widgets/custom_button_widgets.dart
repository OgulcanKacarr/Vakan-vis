import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomButtonWidgets extends StatelessWidget {
  VoidCallback function;
  Widget text;

  CustomButtonWidgets({required this.function, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      child: text,
      style: ElevatedButton.styleFrom(
          elevation: 10,
          foregroundColor:Colors.white,
          backgroundColor: Colors.redAccent,
          shape: StadiumBorder(),
      ),

    );
  }
}
