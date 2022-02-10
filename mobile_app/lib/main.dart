import 'package:flutter/material.dart';
import 'package:mobile_app/route_generator.dart';
import 'package:mobile_app/services/authentication.dart';
import 'package:mobile_app/services/bearer_token.dart';
import 'package:mobile_app/services/weights.dart';
import 'package:mobile_app/state/weight.dart';
import 'package:mobile_app/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String bearer = '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  BearerTokenService bearerTokenService =
      BearerTokenService(sharedPreferences: sharedPreferences);

  bearer = bearerTokenService.get();

  final WeightApiService weightApiService =
      WeightApiService(bearerTokenService: bearerTokenService);

  runApp(MultiProvider(
    providers: [
      Provider(
        create: (_) => BearerTokenService(sharedPreferences: sharedPreferences),
      ),
      Provider(
        create: (_) =>
            AuthenticationService(bearerTokenService: bearerTokenService),
      ),
      ChangeNotifierProvider<WeightProvider>(
          create: (_) => WeightProvider(weightApiService: weightApiService))
    ],
    child: const MyApp(),
  ));
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
