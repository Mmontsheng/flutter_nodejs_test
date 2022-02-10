import 'dart:convert';
import 'dart:io';

import 'package:mobile_app/config/constants.dart';
import 'package:mobile_app/models/authentication/login.dart';
import 'package:mobile_app/models/authentication/register.dart';
import 'package:mobile_app/services/bearer_token.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/services/response_parser.dart';

class AuthenticationService {
  final BearerTokenService bearerTokenService;

  AuthenticationService({required this.bearerTokenService});
  Future<LoginResponse> login(Map<String, String> body) async {
    try {
      final baseUrl = '${Constants.baseUrl}/login';

      http.Response response = await http.post(
        Uri.parse(baseUrl),
        headers: getHeaders(),
        body: jsonEncode(body),
      );
      return ResponseParserUtil.parseLogin(response.body);
    } on SocketException {
      return LoginResponse(status: 500, message: 'No Internet connection');
    }
  }

  Future<RegistrationResponse> register(Map<String, String> body) async {
    try {
      final baseUrl = '${Constants.baseUrl}/sign_up';
      http.Response response = await http.post(
        Uri.parse(baseUrl),
        headers: getHeaders(),
        body: jsonEncode(body),
      );
      return ResponseParserUtil.parseLogin(response.body);
    } on SocketException {
      return RegistrationResponse(
          status: 500, message: 'No Internet connection');
    }
  }

  Map<String, String> getHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    String token = bearerTokenService.get();

    if (token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
}
