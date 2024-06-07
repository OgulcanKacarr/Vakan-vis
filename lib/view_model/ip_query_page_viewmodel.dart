import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vakanuvis/themes/strings.dart';

class IpQueryPageViewmodel extends ChangeNotifier {
  Map<String, dynamic>? _responseData;
  Map<String, dynamic>? get responseData => _responseData;
  String api = "http://ip-api.com/json/";

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  AllStrings _strings = AllStrings();

  Future<void> getDataForIP(
      List<TextEditingController> controllers, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      String targetIp = controllers[0].text.trim();
      if(targetIp.contains("192") || targetIp.length < 5)
        _strings.showSnackBar(context, _strings.enter_public_ip);
      if(targetIp.isEmpty){
        _strings.showSnackBar(context, _strings.chech_ip);
        _isLoading = false;
        notifyListeners();
        return;
      }

      final response = await http.get(Uri.parse(api + targetIp));
      if (response.statusCode == 200) {
        _responseData = jsonDecode(response.body);
      } else {
        _responseData = null;
        _isLoading = false;
        _strings.showSnackBar(context, _strings.empty_value);
        throw Exception('Failed to load data');
      }
    } catch (e) {
      _responseData = null;
      _isLoading = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
