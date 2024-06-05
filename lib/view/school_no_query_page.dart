import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/view/base_scaffold.dart';

//final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class SchoolNoQueryPage extends ConsumerStatefulWidget {
  const SchoolNoQueryPage({super.key});

  @override
  ConsumerState<SchoolNoQueryPage> createState() => _SchoolNoQueryPageState();
}

class _SchoolNoQueryPageState extends ConsumerState<SchoolNoQueryPage> {
  @override
  Widget build(BuildContext context) {
    final List<String> elements = [
      "TC"
    ];
    final List<IconData> icons= [
      Icons.school_outlined,
    ];
    final List<TextEditingController> controllers= [
      TextEditingController(),
    ];
    return BaseScaffold(
      elements: elements,
      icons: icons,
      controllers: controllers,
      onQueryPressed: () {
      },
    );  }
}
