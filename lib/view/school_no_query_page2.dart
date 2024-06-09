import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/phone_query_page_viewmodel.dart';
import 'package:vakanuvis/view_model/school_query_page_viewmodel.dart';
import 'package:vakanuvis/view_model/school_query_page_viewmodel2.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_show_info_container_widgets.dart';
import 'package:vakanuvis/widgets/custom_textfield_widgets.dart';

final riverpod = ChangeNotifierProvider((ref) => SchoolQueryPageViewmodel2());

class SchoolNoQueryPage2 extends ConsumerStatefulWidget {
  const SchoolNoQueryPage2({super.key});

  @override
  ConsumerState<SchoolNoQueryPage2> createState() => _SchoolNoQueryPageState2();
}

class _SchoolNoQueryPageState2 extends ConsumerState<SchoolNoQueryPage2> {
  final List<String> elements = [
    "TC",
  ];
  final List<IconData> icons = [
    Icons.perm_identity,
  ];
  final List<TextEditingController> controllers =
  List.generate(2, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    AllStrings _strings = AllStrings();
    final String? title = ModalRoute.of(context)?.settings.arguments as String?;
    var watch = ref.watch(riverpod);

    return Scaffold(
      appBar: CustomAppBarWidgets(
        title: title ?? _strings.vakanuvis,
        isBack: true,
        isCenter: true,
      ),
      body: _buildBody(watch, _strings),
    );
  }

  Widget _buildBody(SchoolQueryPageViewmodel2 watch, AllStrings strings) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          for (int i = 0; i < elements.length; i++) ...[
            CustomTextFieldWidgets(
              text: elements[i],
              controller: controllers[i], prefix_icon: Icon(icons[i]), keyboard_type: TextInputType.text,
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 20),
          CustomButtonWidgets(
            text: Text(strings.query),
            function: () {
              watch.getDataForSchool(controllers, context);
            },
          ),
          if (watch.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          const SizedBox(height: 20),
          if (watch.responseData.isNotEmpty)
            CustomShowInfoContainerWidgets(
              widget: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: watch.responseData!.length,
                itemBuilder: (context, index) {
                  var data = watch.responseData![index];
                  return ListTile(
                    title: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                      Center(child: SelectableText('${data['ad'] ?? ''} ${data['soyad'] ?? ''}', style: TextStyle(color: Colors.purpleAccent),)),
                    ],),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText('TC: ${data['tc_no'] ?? ''}'),
                        SelectableText('Okul No: ${data['kod'] ?? ''}'),
                        SelectableText('Okul: ${data['durum'] ?? ''}',style: const TextStyle(color: Colors.yellow),),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

