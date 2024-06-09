import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dividerColor = theme.brightness == Brightness.dark ? Colors.white : Colors.black;
    return Divider(
      color: dividerColor,
    );

  }
}