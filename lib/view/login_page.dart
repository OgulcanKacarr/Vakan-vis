import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/services/auth_service.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/login_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_card_widgets.dart';
import 'package:vakanuvis/widgets/custom_divider.dart';
import 'package:vakanuvis/widgets/custom_text_widgets.dart';
import 'package:vakanuvis/widgets/custom_textfield_widgets.dart';

final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class LoginPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  AllStrings _strings = AllStrings();
  AuthService _service = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _service.checkCurrentUser().then((isOnline) {
      if (isOnline) {
        Navigator.pushReplacementNamed(context, "/homepage");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(riverpod);
    var read = ref.read(riverpod);

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: _buildBody(context, watch),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, var watch) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset(_strings.logo)),
            SizedBox(height: 20),
            CustomCardWidgets(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextFieldWidgets(
                      text: _strings.user_email,
                      prefix_icon: const Icon(Icons.email),
                      keyboard_type: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldWidgets(
                      text: _strings.user_password,
                      prefix_icon: const Icon(Icons.lock),
                      keyboard_type: TextInputType.text,
                      isPassword: true,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 20),
                    CustomButtonWidgets(
                      function: () {
                        String email = emailController.text;
                        String password = passwordController.text;
                        watch.checkLoginInfo(context, email, password);
                      },
                      text: CustomTextWidgets(
                        text: _strings.enter,
                        text_size: 15,
                        text_color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextWidgets(
                      text: _strings.or,
                      text_size: 12,
                    ),
                    const SizedBox(height: 10),
                    CustomDivider(),
                    TextButton(
                      onPressed: () {
                        watch.goCreatePage(context);
                      },
                      child: CustomTextWidgets(
                        text: _strings.register,
                        text_size: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
