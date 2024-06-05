import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/strings.dart';

import '../widgets/custom_appbar_widgets.dart';

//final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({super.key});

  @override
  ConsumerState<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> {
  AllStrings strings = AllStrings();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBarWidgets(title: strings.admin,isCenter: true,isBack: true,),
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
