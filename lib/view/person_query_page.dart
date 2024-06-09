import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/view_model/person_query_page_viewmodel.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import 'package:vakanuvis/widgets/custom_button_widgets.dart';
import 'package:vakanuvis/widgets/custom_show_info_container_widgets.dart';
import 'package:vakanuvis/widgets/custom_textfield_widgets.dart';

import '../services/firestore_service.dart';

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
    AllStrings _strings = AllStrings();
    final String? title = ModalRoute.of(context)?.settings.arguments as String?;
    var watch = ref.watch(riverpod);
    FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: CustomAppBarWidgets(
        title: title ?? _strings.vakanuvis,
        isBack: true,
        isCenter: true,
      ),
      body: _buildBody(watch, _strings, firestoreService),
    );
  }

  Widget _buildBody(PersonQueryPageViewmodel watch, AllStrings strings,
      FirestoreService firestore) {
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
              watch.getDataForPerson(controllers, context);
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
                  var data = watch.responseData[index];
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SelectableText(
                            '${data['ADI'] ?? ''}',
                            style: style(Colors.red),
                          ),
                        ),
                        Center(
                          child: SelectableText(
                            '${data['SOYADI'] ?? ''}',
                            style: style(Colors.green),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SelectableText(
                            '${data['NUFUSIL'] ?? ''}',
                            style: style(Colors.blue),
                          ),
                        ),
                        SelectableText('TC: ${data['TC'] ?? ''}'),
                        SelectableText(
                            'DOĞUM TARİHİ: ${data['DOGUMTARIHI'] ?? ''}'),
                        SelectableText(
                            'NUFUS İLÇE: ${data['NUFUSILCE'] ?? ''}'),
                        SelectableText('ANNE ADI: ${data['ANNEADI'] ?? ''}'),
                        SelectableText('ANNE TC: ${data['ANNETC'] ?? ''}'),
                        SelectableText('BABA ADI: ${data['BABAADI'] ?? ''}'),
                        SelectableText('BABA TC: ${data['BABATC'] ?? ''}'),
                        SelectableText('UYRUK: ${data['UYRUK'] ?? ''}'),

                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                            height: 400,
                            child: FutureBuilder<LatLng?>(
                              future: PersonQueryPageViewmodel.getAddressCoordinates(data['NUFUSIL'],data["NUFUSILCE"]),
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
                                        initialZoom: 10.2,
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
        ],
      ),
    );
  }

  TextStyle style(Color color) {
    return TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold);
  }
}
