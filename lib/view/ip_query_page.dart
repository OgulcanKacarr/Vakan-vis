import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/ip_query_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_textfield_widgets.dart';

final riverpod = ChangeNotifierProvider((ref) => IpQueryPageViewmodel());

class IpQueryPage extends ConsumerStatefulWidget {
  const IpQueryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<IpQueryPage> createState() => _IpQueryPageState();
}

class _IpQueryPageState extends ConsumerState<IpQueryPage> {
  final List<String> elements = [
    "Ip",
  ];
  final List<IconData> icons = [
    Icons.network_check,
  ];
  final List<TextEditingController> controllers =
  List.generate(8, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    AllStrings strings = AllStrings();
    var watch = ref.watch(riverpod);

    return Scaffold(
      appBar: CustomAppBarWidgets(
        title: strings.vakanuvis,
        isBack: true,
        isCenter: true,
      ),
      body: _buildBody(watch),
    );
  }

  Widget _buildBody(IpQueryPageViewmodel watch) {
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
              watch.getDataForIP(controllers, context);
            },
          ),
          if (watch.isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          SizedBox(height: 20),
          if (watch.responseData != null)
            ListTile(
              leading: Icon(Icons.person),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ülke kodu: ${watch.responseData!['countryCode'] ?? ''}'),
                  Text('Ülke: ${watch.responseData!['country'] ?? ''}'),
                  Text('Plaka: ${watch.responseData!['region'] ?? ''}'),
                  Text('Bölge: ${watch.responseData!['regionName'] ?? ''}'),
                  Text('Şehir: ${watch.responseData!['city'] ?? ''}'),
                  Text('Zip: ${watch.responseData!['zip'] ?? ''}'),
                  Text('Lat: ${watch.responseData!['lat'] ?? ''}'),
                  Text('Lon: ${watch.responseData!['lon'] ?? ''}'),
                  Text('Zaman dilimi: ${watch.responseData!['timezone'] ?? ''}'),
                  Text('ISP: ${watch.responseData!['isp'] ?? ''}'),
                  Text('Sorgu: ${watch.responseData!['query'] ?? ''}'),
                ],
              ),
            ),
          if (watch.responseData == null)
            Center(
              child: Text('Henüz veri yok.'),
            ),
        ],
      ),
    );
  }
}
