import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/view/base_scaffold.dart';

//final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class IbanQueryPage extends ConsumerStatefulWidget {
  const IbanQueryPage({super.key});

  @override
  ConsumerState<IbanQueryPage> createState() => _IbanQueryPageState();
}

class _IbanQueryPageState extends ConsumerState<IbanQueryPage> {
  final List<String> elements = [
    "TC"
  ];
  final List<IconData> icons= [
    Icons.food_bank,
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
