// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:mobile_app/route_generator.dart';
// import 'package:mobile_app/theme/colors.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     log(isLoggedIn().toString());
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           appBarTheme: const AppBarTheme(
//             iconTheme: IconThemeData(color: AppColors.primary),
//           ),
//           scaffoldBackgroundColor: AppColors.backgroundColor,
//           primarySwatch: Colors.blue,
//         ),
//         debugShowCheckedModeBanner: false,
//         onGenerateRoute: RouteGenerator.generateRoute,
//         initialRoute: isLoggedIn() ? '/' : '/login');
//   }

//   isLoggedIn() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     bool? isLoggedin = localStorage.getBool('isLoggedin');
//     print(isLoggedin);
//     return isLoggedin;
//   }
// }
