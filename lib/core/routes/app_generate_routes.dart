import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/routes/app_routes.dart';
import 'package:smarthome_iot/features/add/presentation/add_routes.dart';
import 'package:smarthome_iot/features/entry_point/presentation/entry_point.dart';
import 'package:smarthome_iot/features/home/presentation/home_routes.dart';
import 'package:smarthome_iot/features/login/presentation/login_routes.dart';
import 'package:smarthome_iot/features/notification/presentation/notification_routes.dart';

class AppGenerateRoutes {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case AppRoutes.login:
        return CupertinoPageRoute(builder: (_) => const LoginRoutes());
      case AppRoutes.entry_point:
        return CupertinoPageRoute(builder: (_) => const EntryPoint());
      case AppRoutes.home:
        return CupertinoPageRoute(builder: (_) => const HomeRoutes());
      case AppRoutes.add:
        return CupertinoPageRoute(builder: (_) => const AddRoutes());
      case AppRoutes.notification:
        return CupertinoPageRoute(builder: (_) => const NotificationRoutes());
    }
    return null;
  }
}
