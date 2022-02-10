import 'dart:convert';

import 'package:mobile_app/models/authentication/login.dart';
import 'package:mobile_app/models/authentication/register.dart';
import 'package:mobile_app/models/weight/base.dart';
import 'package:mobile_app/models/weight/delete.dart';
import 'package:mobile_app/models/weight/get.dart';

class ResponseParserUtil {
  static parseGetWeight(String str) {
    return GetWeightResponse.fromJson(json.decode(str));
  }

  static parseBaseWeight(String str) {
    return BaseWeightResponse.fromJson(json.decode(str));
  }

  static parseDeleteWeight(String str) {
    return DeleteWeightResponse.fromJson(json.decode(str));
  }

  static parseLogin(String str) {
    return LoginResponse.fromJson(json.decode(str));
  }

  static parseRegistration(String str) {
    return RegistrationResponse.fromJson(json.decode(str));
  }
}
