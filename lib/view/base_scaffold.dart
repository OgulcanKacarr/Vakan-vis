import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_textfield_widgets.dart';

class BaseScaffold extends StatelessWidget {
  final AllStrings strings = AllStrings();

  final List<String> elements;
  final List<IconData> icons;
  final List<TextEditingController> controllers;
  final VoidCallback? onQueryPressed; // Yeni eklenen işlev parametresi

  BaseScaffold({required this.elements, required this.icons, required this.controllers, required this.onQueryPressed});

  @override
  Widget build(BuildContext context) {
    final String? title = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBarWidgets(title: title ?? strings.vakanuvis, isCenter: true, isBack: true),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListView(
        children: [
          for (int i = 0; i < elements.length; i++) ...[
            CustomTextFieldWidgets(
              hint_text: elements[i],
              prefix_icon: Icon(icons[i]),
              keyboard_type: TextInputType.text,
              controller: controllers[i],
            ),
            SizedBox(height: 10), //
          ],
          SizedBox(height: 20), //
          CustomButtonWidgets(
            text: Text(strings.query),
            function: onQueryPressed ?? () {},
          ),
        ],
      ),
    );
  }
}
