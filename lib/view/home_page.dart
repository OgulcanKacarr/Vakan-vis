import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/model/query_drwer_elements.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/home_page_viewmodel.dart';
import 'package:vakanuvis/view_model/login_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';


final riverpod = ChangeNotifierProvider((ref) => HomePageViewmodel());

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  AllStrings strings = AllStrings();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(riverpod);
    var read = ref.read(riverpod);

    double device_with = MediaQuery.of(context).size.width;
    double device_heiht = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBarWidgets(title: strings.vakanuvis,isCenter: true,isBack: true,),
      body: _buildBody(context, device_with, device_heiht),
      drawer: DrawerQueryElements(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          watch.showAlertDialog(context);
        },
        child: Icon(Icons.add,size: 30,),
        backgroundColor: Colors.tealAccent.withOpacity(0.50),
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, double device_with, double device_heiht) {
    return Column(
      children: [
        Expanded(flex: 5,child: Container(
          margin: EdgeInsets.only(top: 15,left: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Kullanıcı:",style: TextStyle(color: Colors.green),),
              SizedBox(width: 10,),
              Text("${firebaseAuth.currentUser?.email}",style: TextStyle(
                  color: Colors.red
              )),
            ],
          ),
        ))
      ],
    );
  }
}
