import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplanner/consts/variables.dart';
import 'package:shoplanner/layers/data/services/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpServiceImp implements HttpService {
  late SharedPreferences prefs;

  @override
  Future<String> delete(String slugUrl) async {
    prefs = await SharedPreferences.getInstance();
    final String? salvedToken = prefs.getString('token');
    final response = await http.delete(
        Uri.parse('${Variables.baseUrl}$slugUrl'),
        headers: {'Authorization': 'Bearer $salvedToken'});
    return response.body;
  }

  @override
  Future<String> get(String slugUrl) async {
    prefs = await SharedPreferences.getInstance();
    final String? salvedToken = prefs.getString('token');
    final response = await http.get(Uri.parse('${Variables.baseUrl}$slugUrl'),
        headers: {'Authorization': 'Bearer $salvedToken'});
    return response.body;
  }

  @override
  Future<String> post({
    required String slugUrl,
    required Map body,
  }) async {
    prefs = await SharedPreferences.getInstance();
    final String? salvedToken = prefs.getString('token');
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}$slugUrl'),
      body: json.encode(body),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $salvedToken',
      },
    );
    return response.body;
  }

  @override
  Future<String> put({
    required String slugUrl,
    required Map body,
  }) async {
    prefs = await SharedPreferences.getInstance();
    final String? salvedToken = prefs.getString('token');
    final response = await http.put(
      Uri.parse('${Variables.baseUrl}$slugUrl'),
      body: json.encode(body),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $salvedToken',
      },
    );
    if (response.statusCode != 200) {
      throw Exception(response);
    }
    return response.body;
  }
}
