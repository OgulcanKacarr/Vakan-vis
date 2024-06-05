import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class IbanQueryPage extends ConsumerStatefulWidget {
  const IbanQueryPage({super.key});

  @override
  ConsumerState<IbanQueryPage> createState() => _IbanQueryPageState();
}

class _IbanQueryPageState extends ConsumerState<IbanQueryPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
