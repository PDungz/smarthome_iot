import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/routers/app_routes.dart';
import 'package:smarthome_iot/core/routers/on_generate_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SmartHome IOT',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: OnGenerateRoute.onGenerate,
      initialRoute: AppRoutes.login,
    );
  }
}
