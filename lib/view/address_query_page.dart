import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class AddressQueryPage extends ConsumerStatefulWidget {
  const AddressQueryPage({super.key});

  @override
  ConsumerState<AddressQueryPage> createState() => _AddressQueryPageState();
}

class _AddressQueryPageState extends ConsumerState<AddressQueryPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
