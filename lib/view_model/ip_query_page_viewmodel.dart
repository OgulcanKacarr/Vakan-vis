import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IpQueryPageViewmodel extends ChangeNotifier {
  Map<String, dynamic>? _responseData;
  Map<String, dynamic>? get responseData => _responseData;
  String api = "http://ip-api.com/json/";

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getDataForIP(
      List<TextEditingController> controllers, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      // IP adresini al
      String targetIp = controllers[0].text.trim();

      // HTTP isteği gönder
      final response = await http.get(Uri.parse(api + targetIp));

      // HTTP yanıtını işle
      if (response.statusCode == 200) {
        // JSON yanıtını işle
        _responseData = jsonDecode(response.body);
      } else {
        // Hata durumunda responseData'yi temizle
        _responseData = null;
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Veri alınamadı: $e');
      _responseData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
