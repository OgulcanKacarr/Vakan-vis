import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/view_model/create_page_viewmodel.dart';

import '../themes/strings.dart';
import '../widgets/custom_button_widgets.dart';
import '../widgets/custom_card_widgets.dart';
import '../widgets/custom_text_widgets.dart';
import '../widgets/custom_textfield_widgets.dart';

final riverpod = ChangeNotifierProvider((ref) => CreatePageViewModel());

class CreatePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreatePageState();
}

class _CreatePageState extends ConsumerState<CreatePage> {
  AllStrings strings = AllStrings();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

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
            Image.asset(strings.logo),
            const SizedBox(height: 10,),
            CustomCardWidgets(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextFieldWidgets(
                      text: strings.user_email,
                      prefix_icon: const Icon(Icons.email),
                      keyboard_type: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFieldWidgets(
                      text: strings.user_password,
                      prefix_icon: const Icon(Icons.lock),
                      keyboard_type: TextInputType.text,
                      isPassword: true,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 10),
                    CustomTextFieldWidgets(
                      text: strings.user_password_retry,
                      prefix_icon: Icon(Icons.lock),
                      keyboard_type: TextInputType.text,
                      isPassword: true,
                      controller: rePasswordController,
                    ),
                    const SizedBox(height: 20),
                    CustomButtonWidgets(
                      function: () {
                        String email = emailController.text;
                        String password = passwordController.text;
                        String rePassword = rePasswordController.text;
                        watch.checkCreateInfo(context, email, password, rePassword);
                      },
                      text: CustomTextWidgets(
                        text: strings.register,
                        text_size: 15,
                        text_color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextWidgets(
                      text: strings.or,
                      text_size: 12,
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.black),
                    TextButton(
                      onPressed: () {
                        watch.goLoginPage(context);
                      },
                      child: CustomTextWidgets(
                        text: strings.enter,
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
