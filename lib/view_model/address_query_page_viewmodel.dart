import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:vakanuvis/services/Query_Api.dart';
import 'package:vakanuvis/themes/strings.dart';

class AddressQueryPageViewmodel extends ChangeNotifier {
  List<dynamic> _responseData = [];

  List<dynamic> get responseData => _responseData;
  QueryApi apiService = QueryApi();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  AllStrings _strings = AllStrings();

  Future<void> getDataForAddress(
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
      await apiService.getData('/android/address_api.php', queryParams);
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

  static Future<LatLng> getAddressCoordinates(String a, String b, String c, String d, String e) async {
    double lat = 1;
    double lon = 1;

    try {
      String address = a+" " +d+ " "+e;
      print(address);
      final http.Client client = http.Client();
      final response = await client.get(Uri.parse('https://nominatim.openstreetmap.org/search?q=$address&format=json'));
      print("response: ${response.body}");

      if (response.statusCode == 200) {
        // Yanıt başarılı, veriyi işle
        final List<dynamic> data = json.decode(response.body);
        final latStr = data[0]['lat'];
        final lonStr = data[0]['lon'];

        // String değerleri double değerlere dönüştür
        lat = double.parse(latStr);
        lon = double.parse(lonStr);

        return LatLng(lat, lon);
      } else {
        throw Exception('HTTP isteği başarısız: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata oluştu: $e');
      // Hata durumunda varsayılan bir değer döndür
      return LatLng(lat, lon);
    }
  }
}
