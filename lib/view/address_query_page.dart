import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/address_query_page_viewmodel.dart';
import 'package:vakanuvis/view_model/family_query_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_show_info_container_widgets.dart';
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

  Widget _buildBody(AddressQueryPageViewmodel watch, AllStrings strings) {
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
            text: Text(strings.query),
            function: () {
              watch.getDataForAddress(controllers, context);
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
                  var data = watch.responseData[index];
                  return ListTile(
                    leading: const Icon(Icons.location_city_outlined),
                    title: Center(
                      child: SelectableText(
                        'Adres Bilgileri',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText('DOGUMYERI: ${data['DOGUMYERI'] ?? ''}'),
                        SelectableText('NUFUSILI: ${data['NUFUSILI'] ?? ''}'),
                        SelectableText(
                            'NUFUSILCESI: ${data['NUFUSILCESI'] ?? ''}'),
                        SelectableText('ADRESIL: ${data['ADRESIL'] ?? ''}'),
                        SelectableText('ADRESILCE: ${data['ADRESILCE'] ?? ''}'),
                        SelectableText('MAHALLE: ${data['MAHALLE'] ?? ''}'),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                            height: 400,
                            child: FutureBuilder<LatLng?>(
                              future: AddressQueryPageViewmodel.getAddressCoordinates(data['NUFUSILI'],data["NUFUSILCESI"],data["ADRESIL"],data["ADRESILCE"],data["MAHALLE"]),
                              builder: (BuildContext context, AsyncSnapshot<LatLng?> snapshot) {
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return const Center(child: CircularProgressIndicator());
                                }else if(snapshot.hasData){
                                  LatLng? cord = snapshot.data;
                                  print("lat: ${cord?.latitude}");
                                  print("lon: ${cord?.longitude}");
                                  if(cord != null){
                                    return FlutterMap(
                                      options: MapOptions(
                                        initialCenter: LatLng(cord.latitude,cord.longitude),
                                        initialZoom: 15.1,
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          userAgentPackageName: 'com.ogulcankacar.app',
                                        ),
                                        RichAttributionWidget(
                                          attributions: [
                                            TextSourceAttribution(
                                              'OpenStreetMap contributors',
                                              onTap: () => (Uri.parse('https://openstreetmap.org/copyright')),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }else{
                                    print("data gelmedi}");
                                    return Scaffold();
                                  }

                                }else if(snapshot.hasError){
                                  // Hata durumunu burada ele alabilirsiniz
                                  print("Hata: ${snapshot.error}");
                                  return Text("Bir hata oluştu. Lütfen tekrar deneyin.");
                                }else{
                                  return Scaffold();
                                }

                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          if (watch.responseData.isEmpty)
            Center(
              child: Text(
                strings.long_query,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
