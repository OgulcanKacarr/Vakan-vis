import 'package:flutter/material.dart';
import 'package:vakanuvis/services/firestore_service.dart';

class AdminPageViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> _records = [];
  List<Map<String, dynamic>> get records => _records;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  AdminPageViewModel() {
    fetchRecords();
  }

  void fetchRecords() async {
    _isLoading = true;
    notifyListeners();

    try {
      _records = await _firestoreService.fetchRecords();
    } catch (e) {
      print("Error fetching records: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteRecord(String id) async {
    try {
      await _firestoreService.deleteRecord(id);
      fetchRecords(); // Kayıtları tekrar yükleyin
    } catch (e) {
      print("Error deleting record: $e");
    }
  }
}
