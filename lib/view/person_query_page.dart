import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/person_query_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_textfield_widgets.dart';

final riverpod = ChangeNotifierProvider((ref) => PersonQueryPageViewmodel());

class PersonQueryPage extends ConsumerStatefulWidget {
  const PersonQueryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<PersonQueryPage> createState() => _PersonQueryPageState();
}

class _PersonQueryPageState extends ConsumerState<PersonQueryPage> {
  final List<String> elements = [
    "TC",
    "İsim",
    "Soy isim",
    "Doğum yılı",
    "Şehir",
    "İlçe",
    "Anne adı",
    "Baba adı",
  ];
  final List<IconData> icons = [
    Icons.perm_identity,
    Icons.person,
    Icons.person_outline_rounded,
    Icons.date_range,
    Icons.location_city,
    Icons.location_city_outlined,
    Icons.person_outlined,
    Icons.person_outline_rounded,
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

  Widget _buildBody(PersonQueryPageViewmodel watch) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          for (int i = 0; i < elements.length; i++) ...[
            CustomTextFieldWidgets(
              text: elements[i],
              controller: controllers[i], prefix_icon: Icon(icons[i]), keyboard_type: TextInputType.text,
            ),
            SizedBox(height: 10),
          ],
          SizedBox(height: 20),
          CustomButtonWidgets(
            text: Text("Sorgula"),
            function: () {
              watch.getDataForPerson(controllers, context);
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
                      Text('ADI: ${data['ADI'] ?? ''}'),
                      Text('SOYADI: ${data['SOYADI'] ?? ''}'),
                      Text('TC: ${data['TC'] ?? ''}'),
                      Text('DOĞUM TARİHİ: ${data['DOGUMTARIHI'] ?? ''}'),
                      Text('NUFUS İL: ${data['NUFUSIL'] ?? ''}'),
                      Text('NUFUS İLÇE: ${data['NUFUSILCE'] ?? ''}'),
                      Text('ANNE ADI: ${data['ANNEADI'] ?? ''}'),
                      Text('ANNE TC: ${data['ANNETC'] ?? ''}'),
                      Text('BABA ADI: ${data['BABAADI'] ?? ''}'),
                      Text('BABA TC: ${data['BABATC'] ?? ''}'),
                      Text('UYRUK: ${data['UYRUK'] ?? ''}'),
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
