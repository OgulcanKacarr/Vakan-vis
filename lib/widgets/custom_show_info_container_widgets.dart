import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomShowInfoContainerWidgets extends StatelessWidget {
  Widget widget;

  CustomShowInfoContainerWidgets({required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: widget,
    );
  }
}
