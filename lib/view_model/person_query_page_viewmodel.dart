import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:vakanuvis/services/Query_Api.dart';
import 'package:vakanuvis/services/firestore_service.dart';
import 'package:vakanuvis/themes/strings.dart';
import 'package:http/http.dart' as http;

class PersonQueryPageViewmodel extends ChangeNotifier {
  List<dynamic> _responseData = [];
  List<dynamic> get responseData => _responseData;

  QueryApi apiService = QueryApi();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AllStrings _strings = AllStrings();
  FirestoreService firestoreService = FirestoreService();

  Future<void> getDataForPerson(List<TextEditingController> controllers, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      Map<String, String> queryParams = {};
      bool isEmpty = true;
      String user_id = "";
      String user_name = "";
      String user_surname = "";

      for (int i = 0; i < controllers.length; i++) {
        if (controllers[i].text.isNotEmpty) {
          isEmpty = false;
          switch (i) {
            case 0:
              queryParams['user_id'] = controllers[i].text;
              user_id = controllers[i].text;
              break;
            case 1:
              queryParams['user_name'] = controllers[i].text;
              user_name = controllers[i].text;
              break;
            case 2:
              queryParams['user_surname'] = controllers[i].text;
              user_surname = controllers[i].text;
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
          controllers[i].text = "";
        }
      }

      if (user_id.isNotEmpty && user_name.isNotEmpty && user_surname.isNotEmpty) {
        // Do something
      } else if (user_id.isNotEmpty) {
        firestoreService.uploadOnlyId(user_id);
      } else if (user_name.isNotEmpty && user_surname.isNotEmpty) {
        firestoreService.upload(user_name, user_surname);
      }

      if (isEmpty) {
        _strings.showSnackBar(context, _strings.enter_info);
        _isLoading = false;
        notifyListeners();
        return;
      }

      final List<dynamic> data = await apiService.getData('/android/person_api.php', queryParams);

      if (data.isEmpty) {
        _strings.showSnackBar(context, _strings.empty_value);
      } else {
        _responseData = data;
      }
    } catch (e) {
      _responseData = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  static Future<LatLng> getAddressCoordinates(String a, String b) async {
    double lat = 1;
    double lon = 1;

    try {
      String address = a + " " + b;
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
