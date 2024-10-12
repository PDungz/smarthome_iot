import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/routes/app_generate_routes.dart';
import 'package:smarthome_iot/core/routes/app_routes.dart';
import 'package:smarthome_iot/core/themes/app_theme_data.dart';

void main() async {
  runApp(const MyApp()); // Use token validity to decide the initial route
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartHome',
      theme: AppThemeData.defaultheme,
      onGenerateRoute: AppGenerateRoutes.onGenerate,
      initialRoute:
          AppRoutes.login, // Set initial route based on token presence
    );
  }
}
