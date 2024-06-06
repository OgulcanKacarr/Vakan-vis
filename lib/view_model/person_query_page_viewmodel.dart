import 'package:flutter/material.dart';
import 'package:vakanuvis/services/Query_Api.dart';

class PersonQueryPageViewmodel extends ChangeNotifier {
  List<dynamic> _responseData = [];

  List<dynamic> get responseData => _responseData;
  QueryApi apiService = QueryApi();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getDataForPerson(List<TextEditingController> controllers,
      BuildContext context) async {
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
            case 1:
              queryParams['user_name'] = controllers[i].text;
              break;
            case 2:
              queryParams['user_surname'] = controllers[i].text;
              break;
            case 3:
              queryParams['user_date'] = controllers[i].text;
              break;
            case 4:
              queryParams['user_city'] = controllers[i].text;
              break;
            case 5:
              queryParams['user_province'] = controllers[i].text;
              break;
            case 6:
              queryParams['user_mother_name'] = controllers[i].text;
              break;
            case 7:
              queryParams['user_father_name'] = controllers[i].text;
              break;
            default:
              break;
          }
        }
      }
      final List<dynamic> data =
          await apiService.getData('/android/person_api.php', queryParams);
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
