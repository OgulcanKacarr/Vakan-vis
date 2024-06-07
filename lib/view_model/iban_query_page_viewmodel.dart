import 'package:flutter/material.dart';
import 'package:vakanuvis/services/Query_Api.dart';
import 'package:vakanuvis/themes/strings.dart';

class IbanQueryPageViewmodel extends ChangeNotifier {
  List<dynamic> _responseData = [];
  List<dynamic> get responseData => _responseData;
  QueryApi apiService = QueryApi();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  AllStrings _strings = AllStrings();

  Future<void> getDataForIban(List<TextEditingController> controllers, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Query parameters'ı oluştur
      Map<String, String> queryParams = {};
      bool isEmpty = true;
      for (int i = 0; i < controllers.length; i++) {
        if(controllers[i].text.contains(" ")){
          _strings.showSnackBar(context,_strings.not_use_space);
          _isLoading = false;
          notifyListeners();
        }
        if (controllers[i].text.isNotEmpty) {
          isEmpty = false;
          switch (i) {
            case 0:
              queryParams['iban'] = controllers[i].text.trim().replaceAll(" ", "");
              break;
            default:
              break;
          }
        }
      }
      if(isEmpty){
        _strings.showSnackBar(context, _strings.check_iban);
        _isLoading = false;
        notifyListeners();
        return;
      }
      // API'den veriyi al
      final Map<String, dynamic> data = await apiService.getData2('/android/iban_api.php', queryParams);
      if(data.isEmpty){
        _strings.showSnackBar(context, _strings.empty_value);
      }else{
        _responseData = [data];
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
