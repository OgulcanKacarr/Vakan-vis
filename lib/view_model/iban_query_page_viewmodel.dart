import 'package:flutter/material.dart';
import 'package:vakanuvis/services/Query_Api.dart';

class IbanQueryPageViewmodel extends ChangeNotifier {
  List<dynamic> _responseData = [];
  List<dynamic> get responseData => _responseData;
  QueryApi apiService = QueryApi();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getDataForIban(List<TextEditingController> controllers, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Query parameters'ı oluştur
      Map<String, String> queryParams = {};
      for (int i = 0; i < controllers.length; i++) {
        if (controllers[i].text.isNotEmpty) {
          switch (i) {
            case 0:
              queryParams['iban'] = controllers[i].text;
              break;
            default:
              break;
          }
        }
      }

      // API'den veriyi al
      final Map<String, dynamic> data = await apiService.getData2('/android/iban_api.php', queryParams);

      // Veriyi güncelle
      _responseData = [data]; // Veriyi bir listeye al

    } catch (e) {
      // Hata durumunda işlemleri yap
      print('Veri alınamadı: $e');
      _responseData = [];
    } finally {
      // Yükleme durumunu güncelle ve dinleyicilere bildir
      _isLoading = false;
      notifyListeners();
    }
  }
}
