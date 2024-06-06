import 'package:flutter/material.dart';
import 'package:vakanuvis/services/Query_Api.dart';

class AddressQueryPageViewmodel extends ChangeNotifier {
  List<dynamic> _responseData = [];

  List<dynamic> get responseData => _responseData;
  QueryApi apiService = QueryApi();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getDataForAddress(
      List<TextEditingController> controllers, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
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
      final List<dynamic> data =
      await apiService.getData('/android/address_api.php', queryParams);
      _responseData = data;
      print(_responseData);
    } catch (e) {
      print('Veri alınamadı: $e');
      _responseData = [];
      _isLoading = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
