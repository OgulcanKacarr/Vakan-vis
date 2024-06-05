import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/view/base_scaffold.dart';

//final riverpod = ChangeNotifierProvider((ref) => LoginPageViewModel());
class PersonQueryPage extends ConsumerStatefulWidget {
  const PersonQueryPage({super.key});

  @override
  ConsumerState<PersonQueryPage> createState() => _PersonQueryPageState();
}

class _PersonQueryPageState extends ConsumerState<PersonQueryPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold();
  }
}
