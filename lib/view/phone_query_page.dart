import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/view/base_scaffold.dart';

//final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class PhonesQueryPage extends ConsumerStatefulWidget {
  const PhonesQueryPage({super.key});

  @override
  ConsumerState<PhonesQueryPage> createState() => _PhoneQueryPageState();
}

class _PhoneQueryPageState extends ConsumerState<PhonesQueryPage> {
  final List<String> elements = [
    "TC"
  ];
  final List<IconData> icons= [
    Icons.network_check,
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
    );  }
}
