import 'package:flutter/material.dart';
import 'package:vakanuvis/services/Query_Api.dart';
import 'package:vakanuvis/services/firestore_service.dart';
import 'package:vakanuvis/themes/strings.dart';

class PersonQueryPageViewmodel extends ChangeNotifier {
  List<dynamic> _responseData = [];


  List<dynamic> get responseData => _responseData;
  QueryApi apiService = QueryApi();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  AllStrings _strings = AllStrings();

  Future<void> getDataForPerson(List<TextEditingController> controllers,
      BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      Map<String, String> queryParams = {};
      bool isEmpty = true;

      for (int i = 0; i < controllers.length; i++) {
        if (controllers[i].text.isNotEmpty) {

          isEmpty = false;
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

      if(isEmpty){
        _strings.showSnackBar(context, _strings.enter_info);
        _isLoading = false;
        notifyListeners();
        return;
      }
      final List<dynamic> data =
          await apiService.getData('/android/person_api.php', queryParams);
      if(data.isEmpty){
        _strings.showSnackBar(context, _strings.empty_value);
      }else{
        _responseData = data;
        
      }
    } catch (e) {
      _responseData = [];
      _isLoading = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
