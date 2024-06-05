import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/view/base_scaffold.dart';

//final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class AddressQueryPage extends ConsumerStatefulWidget {
  const AddressQueryPage({super.key});

  @override
  ConsumerState<AddressQueryPage> createState() => _AddressQueryPageState();
}

class _AddressQueryPageState extends ConsumerState<AddressQueryPage> {
  final List<String> elements = [
    "TC"
  ];
  final List<IconData> icons= [
    Icons.location_city,
  ];
  final List<TextEditingController> controllers= [
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
