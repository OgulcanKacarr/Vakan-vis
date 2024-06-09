import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:vakanuvis/widgets/custom_appbar_widgets.dart';
import '../view_model/admin_page_viewmodel.dart';

// ViewModel'i sağlayan provider
final adminPageViewModelProvider = ChangeNotifierProvider((ref) => AdminPageViewModel());

class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // TabController'ı başlat ve atama yap
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(adminPageViewModelProvider);
    AllStrings strings = AllStrings();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(strings.admin,style: TextStyle(color: Colors.tealAccent),),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "TC Taramaları"),
            Tab(text: "Kişi Taramaları"),
          ],
        ),
      ),
      body: _buildBody(viewModel, strings),
    );
  }

  Widget _buildBody(AdminPageViewModel viewModel, AllStrings strings) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildRecordList(viewModel.recordsById, viewModel, strings, "OnlyId"),
            _buildRecordList(viewModel.recordsByNameAndSurname, viewModel, strings, "Users"),
          ],
        ),
      );
    }
  }

  Widget _buildRecordList(List<Map<String, dynamic>> records, AdminPageViewModel viewModel, AllStrings strings, String collection) {
    if (records.isEmpty) {
      return const Center(child: Text("Sorgu bulunamadı"));
    } else {
      return ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];
          return Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              border: Border.all(color: Colors.tealAccent, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: [
                ListTile(
                  title: Text(
                    'Sorgulayan: ${record['sorgulayan']}',
                    style: const TextStyle(color: Colors.purpleAccent),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (collection == "Users") ...[
                        Text(
                          'Aradığı Kişi: ${record['sorgulanan_ad']} ${record['sorgulanan_soyad']}',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ] else ...[
                        Text(
                          'Aradığı kişinin TC: ${record['sorgulanan_tc']}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                      Text(
                        'Sorgu Tarihi: ${record['sorgu_tarihi'].toDate()}',
                        style: const TextStyle(color: Colors.yellow),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                    onPressed: () async {
                      await viewModel.deleteRecord(record['id'], collection);
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
