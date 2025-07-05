import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websoket/routs.dart';
import 'binding/initial_binding.dart';
import 'core/constant/app_routs.dart';
import 'core/constant/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WebSocket Price Tracker',
      theme: AppTheme.lightTheme,
      initialBinding: InitialBinding(),
      getPages: routes,
      initialRoute: AppRouts.homeScreen,
    );
  }
}
