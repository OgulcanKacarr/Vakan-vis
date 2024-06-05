import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextWidgets extends StatelessWidget {

  final String text;
  final double text_size;
  final Color text_color;
  final FontWeight font_weight;

  CustomTextWidgets({
    required this.text,
    this.text_size = 16,
    this.text_color = Colors.black,
    this.font_weight = FontWeight.normal
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(
      fontSize: text_size,
      color: text_color,
      fontWeight: font_weight,
    ),
    );
  }
}
