import 'package:flutter/material.dart';
import 'package:mobile_app/route_generator.dart';
import 'package:mobile_app/services/authentication.dart';
import 'package:mobile_app/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

String bearer = '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  AuthenticationService service =
      AuthenticationService(localStorage: localStorage);
  bearer = service.getBearer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: AppColors.primary),
          ),
          scaffoldBackgroundColor: AppColors.backgroundColor,
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: bearer.isEmpty ? '/login' : '/');
  }
}
