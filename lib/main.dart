import 'package:flutter/material.dart';
import 'core/routes/app_generate_routes.dart';
import 'core/routes/app_routes.dart';
import 'core/themes/app_theme_data.dart';
import 'core/utils/dot_env_util.dart';
import 'core/services/injection_container.dart' as di;
import 'features/login/domain/repositories/token_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DotEnvUtil.initDotEnv();
  await di.init();

  final tokenRepository = di.getIt<TokenRepository>();

  DateTime? tokenExpiryTime = await tokenRepository.getTokenExpiryTime();
  bool isTokenValidExpired =
      tokenExpiryTime != null && tokenExpiryTime.isAfter(DateTime.now());
  String? accessToken = await tokenRepository.getAccessToken();

  String initialRoute = accessToken != null && isTokenValidExpired
      ? AppRoutes.entry_point
      : AppRoutes.login;

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({
    super.key,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartHome',
      theme: AppThemeData.defaultheme,
      onGenerateRoute: AppGenerateRoutes.onGenerate,
      initialRoute: initialRoute, // Use the dynamic initial route
    );
  }
}
