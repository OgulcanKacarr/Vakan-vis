import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakanuvis/model/query_drwer_elements.dart';
import 'package:vakanuvis/services/shared_pref.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/home_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import '../widgets/custom_textfield_widgets.dart';

final riverpod = ChangeNotifierProvider((ref) => HomePageViewmodel());
class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  AllStrings _strings = AllStrings();
  String _host =  "";
  SharedPrefs _sharedPrefs = SharedPrefs();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHost();
  }

  Future<void> _loadHost() async {
    _host = (await _sharedPrefs.read("host")) ?? "";
    if (_host.isEmpty) {
      _host = _strings.host;
    }else{
      _controller.text = _host; //
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(riverpod);
    var read = ref.read(riverpod);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBarWidgets(
        title: _strings.vakanuvis,
        isCenter: true,
        isBack: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _buildBody(context, constraints,watch);
        },
      ),
      drawer: DrawerQueryElements(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          watch.showAlertDialog(context);
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Colors.tealAccent.withOpacity(0.50),
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints, var watch) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15, left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _strings.online_user,
                    style: TextStyle(color: Colors.green, fontSize: _responsiveTextSize(constraints)),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      "${_firebaseAuth.currentUser?.email}",
                      style: TextStyle(color: Colors.red, fontSize: _responsiveTextSize(constraints)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Center(
                child: Image.asset(
                  _strings.logo,
                  width: _responsiveImageSize(constraints),
                  height: _responsiveImageSize(constraints),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  _strings.write,
                  style: TextStyle(color: Colors.purple, fontSize: _responsiveTextSize(constraints)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextFieldWidgets(
                text: _strings.host,
                hint_text: _host,
                prefix_icon: const Icon(Icons.html),
                keyboard_type: TextInputType.text,
                controller: _controller,
              ),
              const SizedBox(height: 10),
              Center(
                child: CustomButtonWidgets(function: () {
                  String host = _controller.text.trim();
                  if (host.isNotEmpty) {
                    _sharedPrefs.save(context, host);
                    _strings.showSnackBar(context, _strings.host_save);
                  } else {
                    _strings.showSnackBar(context, _strings.host_not_empty);
                  }
                }, text: Text(_strings.save)),
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

  double _responsiveImageSize(BoxConstraints constraints) {
    // Adjust the image size based on screen width
    if (constraints.maxWidth > 1200) {
      return 200; // Large screens
    } else if (constraints.maxWidth > 800) {
      return 150; // Medium screens
    } else {
      return 100; // Small screens
    }
  }
}
