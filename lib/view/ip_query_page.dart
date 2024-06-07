import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/ip_query_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_show_info_container_widgets.dart';
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
    AllStrings _strings = AllStrings();
    var watch = ref.watch(riverpod);

    return Scaffold(
      appBar: CustomAppBarWidgets(
        title: _strings.vakanuvis,
        isBack: true,
        isCenter: true,
      ),
      body: _buildBody(watch, _strings),
    );
  }

  Widget _buildBody(IpQueryPageViewmodel watch, AllStrings strings) {
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
            text: Text(
              strings.query,
            ),
            function: () {
              watch.getDataForIP(controllers, context);
            },
          ),
          if (watch.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          const SizedBox(height: 20),
          if (watch.responseData != null)
            CustomShowInfoContainerWidgets(
              widget: ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: SelectableText(
                            'Ülke: ${watch.responseData!['country'] ?? ''}',style: style(Colors.red),)),
                    Center(
                      child: SelectableText(
                          'Bölge: ${watch.responseData!['regionName'] ?? ''}',style: style(Colors.green),),
                    ),
                    Center(
                      child: SelectableText(
                          'Şehir: ${watch.responseData!['city'] ?? ''}',style: style(Colors.blue),),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                        'Ülke kodu: ${watch.responseData!['countryCode'] ?? ''}'),
                    SelectableText(
                        'Plaka: ${watch.responseData!['region'] ?? ''}'),
                    SelectableText('Zip: ${watch.responseData!['zip'] ?? ''}'),
                    SelectableText('Lat: ${watch.responseData!['lat'] ?? ''}'),
                    SelectableText('Lon: ${watch.responseData!['lon'] ?? ''}'),
                    SelectableText(
                        'Zaman dilimi: ${watch.responseData!['timezone'] ?? ''}'),
                    SelectableText('ISP: ${watch.responseData!['isp'] ?? ''}'),
                    SelectableText(
                        'Sorgu: ${watch.responseData!['query'] ?? ''}'),
                  ],
                ),
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
