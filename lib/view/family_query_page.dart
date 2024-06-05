import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class FamilyQueryPage extends ConsumerStatefulWidget {
  const FamilyQueryPage({super.key});

  @override
  ConsumerState<FamilyQueryPage> createState() => _FamilyQueryPageState();
}

class _FamilyQueryPageState extends ConsumerState<FamilyQueryPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
