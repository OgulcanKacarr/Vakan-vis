import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/iban_query_page_viewmodel.dart';
import 'package:vakanuvis/view_model/phone_query_page_viewmodel.dart';
import 'package:vakanuvis/view_model/school_query_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_textfield_widgets.dart';

final riverpod = ChangeNotifierProvider((ref) => IbanQueryPageViewmodel());

class IbanQueryPage extends ConsumerStatefulWidget {
  const IbanQueryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<IbanQueryPage> createState() => _IbanQueryPageState();
}

class _IbanQueryPageState extends ConsumerState<IbanQueryPage> {
  final List<String> elements = [
    "Iban",
  ];
  final List<IconData> icons = [
    Icons.food_bank,
  ];
  final List<TextEditingController> controllers =
  List.generate(2, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    AllStrings strings = AllStrings();
    final String? title = ModalRoute.of(context)?.settings.arguments as String?;
    var watch = ref.watch(riverpod);

    return Scaffold(
      appBar: CustomAppBarWidgets(
        title: title ?? strings.vakanuvis,
        isBack: true,
        isCenter: true,
      ),
      body: _buildBody(watch),
    );
  }

  Widget _buildBody(IbanQueryPageViewmodel watch) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          SizedBox(height: 20),
          CustomButtonWidgets(
            text: Text("Sayfayı aç"),
            function: () {
              watch.openWeb();
            },
          ),
        ],
      ),
    );
  }
}

