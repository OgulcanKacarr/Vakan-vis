import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vakanuvis/themes/strings.dart';

class CustomTextFieldWidgets extends StatelessWidget {
  String hint_text;
  Icon prefix_icon;
  TextInputType keyboard_type;
  bool isPassword;


  CustomTextFieldWidgets({
    required this.hint_text,
    required this.prefix_icon,
    required this.keyboard_type,
    this.isPassword = false
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboard_type,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        labelText: hint_text,
        prefixIcon: prefix_icon,
      ),
    );
  }
}
