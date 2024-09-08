import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/routers/app_routes.dart';
import 'package:smarthome_iot/view/add/add_page.dart';
import 'package:smarthome_iot/view/auth/login_page.dart';
import 'package:smarthome_iot/view/device/device_page.dart';
import 'package:smarthome_iot/view/entry_point/entry_point_ui.dart';
import 'package:smarthome_iot/view/home/home_page.dart';
import 'package:smarthome_iot/view/profile/profile_page.dart';

class OnGenerateRoute {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case AppRoutes.login:
        return CupertinoPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.entrypoint_ui:
        return CupertinoPageRoute(builder: (_) => const EntryPointUi());
      case AppRoutes.home:
        return CupertinoPageRoute(builder: (_) => const HomePage());
      case AppRoutes.add:
        return CupertinoPageRoute(builder: (_) => const AddPage());
      case AppRoutes.device:
        return CupertinoPageRoute(builder: (_) => const DevicePage());
      case AppRoutes.profile:
        return CupertinoPageRoute(builder: (_) => const ProfilePage());
      default:
        return _errorRoute(); // Điều hướng tới màn hình lỗi nếu không tìm thấy tuyến đường
    }
  }

  static Route _errorRoute() {
    return CupertinoPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Something went wrong!')),
      ),
    );
  }
}
