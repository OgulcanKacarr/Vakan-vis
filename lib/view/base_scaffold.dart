import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';

class BaseScaffold extends StatelessWidget {
  AllStrings strings = AllStrings();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBarWidgets(title: strings.vakanuvis,isCenter: true,isBack: true,),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    return Column(
        children: [

        ],
    );
  }
}
