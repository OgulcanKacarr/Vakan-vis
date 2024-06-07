import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import '../view_model/admin_page_viewmodel.dart';

// ViewModel'i sağlayan provider
final adminPageViewModelProvider = ChangeNotifierProvider((ref) => AdminPageViewModel());

class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({super.key});

  @override
  ConsumerState<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> {
  AllStrings strings = AllStrings();

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(adminPageViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBarWidgets(
        title: strings.admin,
        isCenter: true,
        isBack: true,
      ),
      body: _buildBody(viewModel),
    );
  }

  Widget _buildBody(AdminPageViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (viewModel.records.isEmpty) {
      return const Center(child: Text("No records found."));
    } else {
      return ListView.builder(
        itemCount: viewModel.records.length,
        itemBuilder: (context, index) {
          final record = viewModel.records[index];
          return Container(
            margin: const EdgeInsets.all(8.0),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              border: Border.all(color: Colors.tealAccent, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: [
                ListTile(
                  title: Center(
                    child: Text(
                      'Sorgulayan: ${record['sorgulayan']}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aradığı Kişi: ${record['sorgulanan_ad']} ${record['sorgulanan_soyad']}',
                        style: const TextStyle(color: Colors.blue),
                      ),
                      Text(
                        'Aradığı kişinin TC: ${record['sorgulanan_tc']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Sorgu Tarihi: ${record['sorgu_tarihi'].toDate()}',
                        style: const TextStyle(color: Colors.pinkAccent),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red, size: 20),
                    onPressed: () async {
                      // Belgeyi Firestore'dan sil ve listeyi yenile
                      await viewModel.deleteRecord(record['id']);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
