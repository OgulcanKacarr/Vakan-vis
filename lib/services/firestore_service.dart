import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void upload(String target_user_id, String target_user_name, String target_surname) {
    String? current_user = _auth.currentUser?.email.toString();
    Map<String, dynamic> log = {
      "sorgulayan": current_user,
      "sorgulanan_tc": target_user_id,
      "sorgulanan_ad": target_user_name,
      "sorgulanan_soyad": target_surname,
      "sorgu_tarihi": FieldValue.serverTimestamp()
    };
    _firebaseFirestore.collection("Users").add(log);
  }

  Future<List<Map<String, dynamic>>> fetchRecords() async {
    List<Map<String, dynamic>> records = [];
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("Users")
          .orderBy('sorgu_tarihi', descending: true)
          .get();

      records = querySnapshot.docs
          .map((doc) => {
        'id': doc.id,
        'sorgulayan': doc['sorgulayan'],
        'sorgulanan_tc': doc['sorgulanan_tc'],
        'sorgulanan_ad': doc['sorgulanan_ad'],
        'sorgulanan_soyad': doc['sorgulanan_soyad'],
        'sorgu_tarihi': doc['sorgu_tarihi'],
      })
          .toList();
    } catch (e) {
      print("Error fetching records: $e");
    }
    return records;
  }

  Future<void> deleteRecord(String id) async {
    try {
      await _firebaseFirestore.collection('Users').doc(id).delete();
    } catch (e) {
      print("Error deleting record: $e");
    }
  }
}
