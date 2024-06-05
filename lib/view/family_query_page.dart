import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/view/base_scaffold.dart';

//final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class FamilyQueryPage extends ConsumerStatefulWidget {
  const FamilyQueryPage({super.key});

  @override
  ConsumerState<FamilyQueryPage> createState() => _FamilyQueryPageState();
}

class _FamilyQueryPageState extends ConsumerState<FamilyQueryPage> {
  final List<String> elements = [
    "TC"
  ];
  final List<IconData> icons= [
    Icons.family_restroom,
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
