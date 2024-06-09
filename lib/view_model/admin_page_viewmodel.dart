import 'package:flutter/material.dart';
import 'package:vakanuvis/services/firestore_service.dart';

class AdminPageViewModel extends ChangeNotifier {
  final FirestoreService firestoreService = FirestoreService();
  bool _isLoading = false;
  List<Map<String, dynamic>> _recordsByNameAndSurname = [];
  List<Map<String, dynamic>> _recordsById = [];

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get recordsByNameAndSurname => _recordsByNameAndSurname;
  List<Map<String, dynamic>> get recordsById => _recordsById;

  AdminPageViewModel() {
    fetchAllRecords();
  }

  Future<void> fetchAllRecords() async {
    _isLoading = true;
    notifyListeners();

    try {
      _recordsByNameAndSurname = await firestoreService.fetchRecordsByNameAndSurname();
      _recordsById = await firestoreService.fetchRecordsById();
    } catch (e) {
      print("Error fetching records: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteRecord(String id, String collection) async {
    await firestoreService.deleteRecord(id, collection);
    fetchAllRecords();
  }
}
