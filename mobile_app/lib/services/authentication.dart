import 'dart:convert';

import 'package:mobile_app/config/constants.dart';
import 'package:mobile_app/models/base.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  final SharedPreferences localStorage;

  AuthenticationService({required this.localStorage});

  Future<String?> login(String username, String password) async {
    final baseUrl = '${Constants.base_url}/login';

    http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password,
      }),
    );
    LoginModel model = parseFromJson(response.body);
    if (response.statusCode == 200) {
      localStorage.setString('bearer', model.result);
      return '';
    }
    return model.message;
  }

  String getBearer() {
    return localStorage.getString("bearer") == null
        ? ''
        : localStorage.getString("bearer")!;
  }
}
