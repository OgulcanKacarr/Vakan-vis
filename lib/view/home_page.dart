import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/login_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_card_widgets.dart';
import 'package:vakanuvis/widgets/custom_text_widgets.dart';
import 'package:vakanuvis/widgets/custom_textfield_widgets.dart';

final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  AllStrings strings = AllStrings();
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {


    double device_with = MediaQuery.of(context).size.width;
    double device_heiht = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildBody(context, device_with, device_heiht),
    );
  }

  Widget _buildBody(BuildContext context, double device_with, double device_heiht) {
    var watch = ref.watch(riverpod);
    var read = ref.read(riverpod);
    return ElevatedButton(
      child: Text("Çık"),
      onPressed: (){
        firebaseAuth.signOut();
        Navigator.pushReplacementNamed(context, "/createpage");
      },

    );
  }
}
