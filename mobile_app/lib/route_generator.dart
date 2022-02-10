import 'package:flutter/cupertino.dart';
import 'package:mobile_app/screens/error.dart';
import 'package:mobile_app/screens/auth/login.dart';
import 'package:mobile_app/screens/auth/register.dart';
import 'package:mobile_app/screens/home.dart';
import 'package:mobile_app/widgets/custom_page_route.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case "/":
        return CustomPageRoute(builder: (_) => const HomeScreen());
      case "/login":
        return CustomPageRoute(builder: (_) => const LoginScreen());
      case "/register":
        return CustomPageRoute(builder: (_) => const RegisterScreen());
      default:
        return CustomPageRoute(builder: (_) => const ErrorScreen());
    }
  }
}
