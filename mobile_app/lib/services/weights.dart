import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_app/config/constants.dart';
import 'package:mobile_app/models/weight/base.dart';
import 'package:mobile_app/models/weight/delete.dart';
import 'package:mobile_app/models/weight/get.dart';
import 'package:mobile_app/services/bearer_token.dart';
import 'package:mobile_app/services/response_parser.dart';

class WeightApiService {
  final BearerTokenService bearerTokenService;

  WeightApiService({required this.bearerTokenService});

  Future<GetWeightResponse> load() async {
    try {
      final baseUrl = '${Constants.baseUrl}/get_weight_history';
      http.Response response = await http.get(
        Uri.parse(baseUrl),
        headers: getHeaders(),
      );
      return ResponseParserUtil.parseGetWeight(response.body);
    } on SocketException {
      return GetWeightResponse(status: 500, message: 'No Internet connection');
    }
  }

  Future<DeleteWeightResponse> delete(String id) async {
    try {
      final baseUrl = '${Constants.baseUrl}/delete_weight/$id';

      http.Response response = await http.delete(
        Uri.parse(baseUrl),
        headers: getHeaders(),
      );
      return ResponseParserUtil.parseDeleteWeight(response.body);
    } on SocketException {
      return DeleteWeightResponse(
          status: 500, message: 'No Internet connection');
    }
  }

  Future<BaseWeightResponse> create(String value) async {
    try {
      final baseUrl = '${Constants.baseUrl}/save_weight';
      Map<String, String> body = {
        "value": value,
      };
      http.Response response = await http.post(
        Uri.parse(baseUrl),
        headers: getHeaders(),
        body: jsonEncode(body),
      );
      return ResponseParserUtil.parseBaseWeight(response.body);
    } on SocketException {
      return BaseWeightResponse(status: 500, message: 'No Internet connection');
    }
  }

  Future<BaseWeightResponse> update(String id, String value) async {
    try {
      final baseUrl = '${Constants.baseUrl}/update_weight/$id';

      Map<String, String> body = {
        "value": value,
      };
      http.Response response = await http.put(
        Uri.parse(baseUrl),
        headers: getHeaders(),
        body: jsonEncode(body),
      );
      return ResponseParserUtil.parseBaseWeight(response.body);
    } on SocketException {
      return BaseWeightResponse(status: 500, message: 'No Internet connection');
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
