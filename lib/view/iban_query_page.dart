import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/family_query_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_textfield_widgets.dart';

import '../view_model/iban_query_page_viewmodel.dart';

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
  List.generate(8, (_) => TextEditingController());

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
            text: Text("Sorgula"),
            function: () {
              watch.getDataForIban(controllers, context);
            },
          ),
          if (watch.isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          SizedBox(height: 20),
          if (watch.responseData != null && watch.responseData!.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: watch.responseData!.length,
              itemBuilder: (context, index) {
                var data = watch.responseData![index];
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Banka Adı: ${data['Banka Adı'] ?? ''}'),
                      Text('Banka Kodu: ${data['Banka Kodu'] ?? ''}'),
                      Text('Swift: ${data['Swift'] ?? ''}'),
                      Text('Hesap No: ${data['Hesap No'] ?? ''}'),
                      Text('Şube Adı: ${data['Şube Adı'] ?? ''}'),
                      Text('Şube Kodu: ${data['Şube Kodu'] ?? ''}'),
                      Text('İl: ${data['İl'] ?? ''}'),
                      Text('İlçe: ${data['İlçe'] ?? ''}'),
                      Text('Telefon: ${data['Telefon'] ?? ''}'),
                      Text('Fax: ${data['Fax'] ?? ''}'),
                      Text('Adres: ${data['Adres'] ?? ''}'),
                    ],
                  ),
                );
              },
            ),
          if (watch.responseData == null || watch.responseData!.isEmpty)
            Center(
              child: Text('Henüz veri yok.'),
            ),
        ],
      ),
    );
  }
}
