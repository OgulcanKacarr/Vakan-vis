import 'package:flutter/material.dart';
import 'package:vakanuvis/services/Query_Api.dart';
import 'package:vakanuvis/themes/strings.dart';

class PhoneQueryPageViewmodel extends ChangeNotifier {
  List<dynamic> _responseData = [];

  List<dynamic> get responseData => _responseData;
  QueryApi apiService = QueryApi();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  AllStrings _strings = AllStrings();

  Future<void> getDataForPhone(
      List<TextEditingController> controllers, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      Map<String, String> queryParams = {};
      bool isEmpty = true;
      for (int i = 0; i < controllers.length; i++) {
        if (controllers[i].text.isNotEmpty) {
          if(controllers[i].text.startsWith("0")){
            isEmpty = true;
            _isLoading = false;
            notifyListeners();
            _strings.showSnackBar(context, _strings.not_use_zero);
          }

          isEmpty = false;
          switch (i) {
            case 0:
              queryParams['user_id'] = controllers[i].text;
              break;
            case 1:
              queryParams['user_gsm'] = controllers[i].text;
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
          await apiService.getData('/android/phone_api.php', queryParams);
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
