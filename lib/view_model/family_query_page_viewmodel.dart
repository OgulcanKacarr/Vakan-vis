import 'package:flutter/material.dart';
import 'package:vakanuvis/services/Query_Api.dart';
import 'package:vakanuvis/themes/strings.dart';

class FamilyQueryPageViewmodel extends ChangeNotifier {
  List<dynamic> _responseData = [];

  List<dynamic> get responseData => _responseData;
  QueryApi apiService = QueryApi();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  AllStrings _strings = AllStrings();

  Future<void> getDataForFamily(
      List<TextEditingController> controllers, BuildContext context) async {
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
            default:
              break;
          }
        }
        controllers[i].text = "";
      }
      if(isEmpty){
        _strings.showSnackBar(context, _strings.chech_id);
        _isLoading = false;
        notifyListeners();
        return;
      }
      final List<dynamic> data =
          await apiService.getData('/android/familly_api.php', queryParams);
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
