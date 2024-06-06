import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakanuvis/model/query_drwer_elements.dart';
import 'package:vakanuvis/services/shared_pref.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/home_page_viewmodel.dart';
import 'package:vakanuvis/view_model/login_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import '../widgets/custom_textfield_widgets.dart';

final riverpod = ChangeNotifierProvider((ref) => HomePageViewmodel());

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  AllStrings strings = AllStrings();
  String host = "";
  SharedPrefs sharedPrefs = SharedPrefs();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHost();
  }

  Future<void> _loadHost() async {
    host = (await sharedPrefs.read("host")) ?? "";
    if (host.isEmpty) {
      host = "Host girin";
    }
    controller.text = host; // TextField'i başlatırken host değerini ayarla
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(riverpod);
    var read = ref.read(riverpod);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBarWidgets(
        title: strings.vakanuvis,
        isCenter: true,
        isBack: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _buildBody(context, constraints);
        },
      ),
      drawer: DrawerQueryElements(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          watch.showAlertDialog(context);
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Colors.tealAccent.withOpacity(0.50),
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        Container(
          margin: EdgeInsets.only(top: 15, left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(
                  "Kullanıcı: ",
                  style: TextStyle(color: Colors.green, fontSize: _responsiveTextSize(constraints)),
                ),
                SizedBox(width: 10),
                Text(
                  "${firebaseAuth.currentUser?.email}",
                  style: TextStyle(color: Colors.red, fontSize: _responsiveTextSize(constraints)),
                ),
              ],),
              SizedBox(height: 50),
              Center(child: Image.asset("assets/images/dragon_logo.png")),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Kılıcın parlattığı, Kalemin aydınlattığı ",
                  style: TextStyle(color: Colors.purple, fontSize: _responsiveTextSize(constraints)),
                ),
              ),
              SizedBox(height: 10),
              CustomTextFieldWidgets(
                text: "Host",
                hint_text: host,
                prefix_icon: Icon(Icons.html),
                keyboard_type: TextInputType.text,
                controller: controller,
              ),
              SizedBox(height: 10),
              Center(
                child: CustomButtonWidgets(function: (){
                  String host = controller.text.trim();
                  if (host.isNotEmpty) {
                    sharedPrefs.save(context, host);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Host kaydedildi.")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Host boş olamaz!")),
                    );
                  }
                }, text: Text("Kaydet")),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double _responsiveTextSize(BoxConstraints constraints) {
    // Adjust the font size based on screen width
    if (constraints.maxWidth > 1200) {
      return 24; // Large screens
    } else if (constraints.maxWidth > 800) {
      return 20; // Medium screens
    } else {
      return 16; // Small screens
    }
  }
}
