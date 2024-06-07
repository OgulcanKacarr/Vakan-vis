import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vakanuvis/services/shared_pref.dart';

class QueryApi {
  final SharedPrefs sharedPrefs = SharedPrefs();

  Future<List<dynamic>> getData(String path, Map<String, String> queryParams) async {
    try {
      String? baseUrl = await sharedPrefs.read('host');

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception('Base URL is not set in shared preferences.');
      }
      final Uri url = Uri.parse(baseUrl + path).replace(queryParameters: queryParams);

      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Map<String, dynamic>> getData2(String path, Map<String, String> queryParams) async {
    try {
      String? baseUrl = await sharedPrefs.read('host');

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception('Base URL is not set in shared preferences.');
      }

      final Uri url = Uri.parse(baseUrl + path).replace(queryParameters: queryParams);

      final http.Client client = http.Client();
      final http.Response response = await client.get(
        url,
      ).timeout(Duration(minutes: 30));

      print("body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }


}
