import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/services/auth_service.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/login_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_card_widgets.dart';
import 'package:vakanuvis/widgets/custom_text_widgets.dart';
import 'package:vakanuvis/widgets/custom_textfield_widgets.dart';

final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());

class LoginPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  AllStrings strings = AllStrings();
  AuthService service = AuthService();

  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    service.checkCurrentUser().then((isOnline) {
      if (isOnline) {
        Navigator.pushReplacementNamed(context, "/homepage");
      } else {
        // Kullanıcı offline ise yapılacak işlemler
        print("giriş yok");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double device_with = MediaQuery.of(context).size.width;
    double device_heiht = MediaQuery.of(context).size.height;
    var watch = ref.watch(riverpod);
    var read = ref.read(riverpod);
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildBody(context, device_with, device_heiht,watch),
    );
  }

  Widget _buildBody(BuildContext context, double device_with, double device_heiht, var watch) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: device_with - 10,
            alignment: Alignment.center,
            child: Expanded(
                child: CustomCardWidgets(
              child: Padding(
                padding: EdgeInsets.only(left: 12, right: 12,top: 15,bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFieldWidgets(
                      text: strings.user_email,
                      prefix_icon: Icon(Icons.email),
                      keyboard_type: TextInputType.emailAddress,
                      controller: email_controller,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextFieldWidgets(
                      text: strings.user_password,
                      prefix_icon: Icon(Icons.lock),
                      keyboard_type: TextInputType.text,
                      isPassword: true,
                      controller: password_controller,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButtonWidgets(
                        function: () {
                          String email = email_controller.text;
                          String password = password_controller.text;
                          watch.checkLoginInfo(context, email, password);
                        },
                        text: CustomTextWidgets(
                          text: strings.enter,
                          text_size: 15,
                          text_color: Colors.white,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextWidgets(
                      text: strings.or,
                      text_size: 12,
                    ),
                    SizedBox(height: 5,),
                    Container(height: 2,width: double.infinity,color: Colors.black,),
                    SizedBox(height: 2,),
                    TextButton(onPressed: (){
                      watch.goCreatePage(context);
                    }, child: CustomTextWidgets(text: strings.register, text_size: 12,))
                  ],
                ),
              ),
            )),
          )
        ],
      ),
    );
  }
}
