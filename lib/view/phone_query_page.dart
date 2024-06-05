import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class PhonesQueryPage extends ConsumerStatefulWidget {
  const PhonesQueryPage({super.key});

  @override
  ConsumerState<PhonesQueryPage> createState() => _PhoneQueryPageState();
}

class _PhoneQueryPageState extends ConsumerState<PhonesQueryPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
