import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/family_query_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_show_info_container_widgets.dart';
import 'package:vakanuvis/widgets/custom_textfield_widgets.dart';

import '../view_model/iban_query_page_viewmodel.dart';

final riverpod = ChangeNotifierProvider((ref) => IbanQueryPageViewmodel());

class IbanQueryPage extends ConsumerStatefulWidget {
  const IbanQueryPage({super.key});

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
      body: _buildBody(watch,_strings),
    );
  }

  Widget _buildBody(IbanQueryPageViewmodel watch, AllStrings strings) {
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
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 20),
          CustomButtonWidgets(
            text: Text(strings.query,),
            function: () {
              watch.getDataForIban(controllers, context);
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
                itemCount: watch.responseData.length,
                itemBuilder: (context, index) {
                  var data = watch.responseData![index];
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText('Banka Adı: ${data['Banka Adı'] ?? ''}'),
                        SelectableText('Banka Kodu: ${data['Banka Kodu'] ?? ''}'),
                        SelectableText('Swift: ${data['Swift'] ?? ''}'),
                        SelectableText('Hesap No: ${data['Hesap No'] ?? ''}'),
                        SelectableText('Şube Adı: ${data['Şube Adı'] ?? ''}'),
                        SelectableText('Şube Kodu: ${data['Şube Kodu'] ?? ''}'),
                        SelectableText('İl: ${data['İl'] ?? ''}'),
                        SelectableText('İlçe: ${data['İlçe'] ?? ''}'),
                        SelectableText('Telefon: ${data['Telefon'] ?? ''}'),
                        SelectableText('Fax: ${data['Fax'] ?? ''}'),
                        SelectableText('Adres: ${data['Adres'] ?? ''}'),
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
