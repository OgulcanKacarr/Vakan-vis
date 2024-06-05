import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/view/base_scaffold.dart';

//final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class PersonQueryPage extends ConsumerStatefulWidget {
  const PersonQueryPage({super.key});

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
    Icons.person_2,
    Icons.date_range,
    Icons.location_city,
    Icons.location_city_outlined,
    Icons.person_outlined,
    Icons.person_outline_rounded,
  ];
  final List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      elements: elements,
      icons: icons,
      controllers: controllers,
      onQueryPressed: () {

      },
    );
  }
}
