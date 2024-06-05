import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class IpQueryPage extends ConsumerStatefulWidget {
  const IpQueryPage({super.key});

  @override
  ConsumerState<IpQueryPage> createState() => _IpQueryPageState();
}

class _IpQueryPageState extends ConsumerState<IpQueryPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
