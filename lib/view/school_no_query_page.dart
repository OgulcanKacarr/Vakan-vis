import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class SchoolNoQueryPage extends ConsumerStatefulWidget {
  const SchoolNoQueryPage({super.key});

  @override
  ConsumerState<SchoolNoQueryPage> createState() => _SchoolNoQueryPageState();
}

class _SchoolNoQueryPageState extends ConsumerState<SchoolNoQueryPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
