import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/widgets/custom_text_widgets.dart';
import '../themes/custom_colors.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  CustomColors customColors = CustomColors();
  AllStrings _strings = AllStrings();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, "/loginpage");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Image.asset(
              _strings.logo,
              width: 200,
              height: 200,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: CustomTextWidgets(
              text: _strings.vakanuvis,
              text_color: customColors.turkuaz,
            ),
          ),
        ),
      ],
    );
  }
}
