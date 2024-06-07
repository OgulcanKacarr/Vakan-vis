import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/family_query_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_show_info_container_widgets.dart';
import 'package:vakanuvis/widgets/custom_textfield_widgets.dart';

final riverpod = ChangeNotifierProvider((ref) => FamilyQueryPageViewmodel());

class FamilyQueryPage extends ConsumerStatefulWidget {
  const FamilyQueryPage({super.key});

  @override
  ConsumerState<FamilyQueryPage> createState() => _FamilyQueryPageState();
}

class _FamilyQueryPageState extends ConsumerState<FamilyQueryPage> {
  final List<String> elements = [
    "TC",
  ];
  final List<IconData> icons = [
    Icons.perm_identity,
  ];
  final List<TextEditingController> controllers =
      List.generate(8, (_) => TextEditingController());

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

  Widget _buildBody(FamilyQueryPageViewmodel watch, AllStrings strings) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          for (int i = 0; i < elements.length; i++) ...[
            CustomTextFieldWidgets(
              text: elements[i],
              controller: controllers[i],
              prefix_icon: Icon(icons[i]),
              keyboard_type: TextInputType.text,
            ),
            SizedBox(height: 10),
          ],
          SizedBox(height: 20),
          CustomButtonWidgets(
            text: Text(strings.query),
            function: () {
              watch.getDataForFamily(controllers, context);
            },
          ),
          if (watch.isLoading)
            Center(
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
                    leading: const Icon(Icons.person),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          '${data['YAKINLIK'] ?? ''}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText('ADI: ${data['ADI'] ?? ''}', style: style(Colors.green),),
                        SelectableText('SOYADI: ${data['SOYADI'] ?? ''}', style: style(Colors.green),),
                        SelectableText('TC: ${data['TC'] ?? ''}'),
                        SelectableText(
                            'DOĞUM TARİHİ: ${data['DOGUMTARIHI'] ?? ''}'),
                        SelectableText('NUFUS İL: ${data['NUFUSIL'] ?? ''}'),
                        SelectableText(
                            'NUFUS İLÇE: ${data['NUFUSILCE'] ?? ''}'),
                        SelectableText('ANNE ADI: ${data['ANNEADI'] ?? ''}'),
                        SelectableText('ANNE TC: ${data['ANNETC'] ?? ''}'),
                        SelectableText('BABA ADI: ${data['BABAADI'] ?? ''}'),
                        SelectableText('BABA TC: ${data['BABATC'] ?? ''}'),
                        SelectableText('UYRUK: ${data['UYRUK'] ?? ''}'),
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
  TextStyle style(Color color) {
    return TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold);
  }
}
