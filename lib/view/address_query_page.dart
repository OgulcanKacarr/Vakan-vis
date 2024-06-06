import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/address_query_page_viewmodel.dart';
import 'package:vakanuvis/view_model/family_query_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_textfield_widgets.dart';

final riverpod = ChangeNotifierProvider((ref) => AddressQueryPageViewmodel());

class AddressQueryPage extends ConsumerStatefulWidget {
  const AddressQueryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddressQueryPage> createState() => _AdressQueryPageState();
}

class _AdressQueryPageState extends ConsumerState<AddressQueryPage> {
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

  Widget _buildBody(AddressQueryPageViewmodel watch) {
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
              watch.getDataForAddress(controllers, context);
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
                      Center(
                          child: Text(
                            '${data['YAKINLIK'] ?? ''}',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )),
                      Text('DOGUMYERI: ${data['DOGUMYERI'] ?? ''}'),
                      Text('NUFUSILI: ${data['NUFUSILI'] ?? ''}'),
                      Text('NUFUSILCESI: ${data['NUFUSILCESI'] ?? ''}'),
                      Text('ADRESIL: ${data['ADRESIL'] ?? ''}'),
                      Text('ADRESILCE: ${data['ADRESILCE'] ?? ''}'),
                      Text('MAHALLE: ${data['MAHALLE'] ?? ''}'),
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

