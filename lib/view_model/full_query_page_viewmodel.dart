import 'package:flutter/material.dart';
import 'package:vakanuvis/services/Query_Api.dart';

class FullQueryPageViewmodel extends ChangeNotifier {
  List<dynamic> _responseData = []; // responseData tipini List<dynamic> olarak değiştiriyoruz

  List<dynamic> get responseData => _responseData;
  QueryApi apiService = QueryApi();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getDataForFullQuery(
      List<TextEditingController> controllers, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Query parameters'ı oluştur
      Map<String, String> queryParams = {};
      for (int i = 0; i < controllers.length; i++) {
        if (controllers[i].text.isNotEmpty) {
          switch (i) {
            case 0:
              queryParams['user_id'] = controllers[i].text;
              break;
            default:
              break;
          }
        }

      }
      String queryString = '/android/rapor_api.php?';
      queryParams.forEach((key, value) {
        queryString += '$key=$value&';
      });
      print('Sorgu Dizesi: $queryString');

      Map<String, dynamic> data = await apiService.getData2('/android/rapor_api.php', queryParams);
      _responseData = [data];
      print(_responseData);
    } catch (e) {
      print('Veri alınamadı: $e');
      _responseData = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
