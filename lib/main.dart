import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/common/global_setting/presentation/global_info_bloc/global_info_bloc.dart';
import 'package:smarthome_iot/firebase_options.dart';
import 'package:smarthome_iot/l10n/generated/app_localizations.dart';
import 'core/routes/app_generate_routes.dart';
import 'core/routes/app_routes.dart';
import 'core/services/injection_container.dart';
import 'core/themes/app_theme_data.dart';
import 'core/utils/dot_env_util.dart';
import 'core/services/injection_container.dart' as di;
import 'features/login/domain/repositories/token_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
    return BlocProvider<GlobalInfoBloc>(
      create: (_) => GlobalInfoBloc(getIt())..add(GetGlobalInfo()),
      child: BlocBuilder<GlobalInfoBloc, GlobalInfoState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SmartHome',
            theme: AppThemeData.defaultheme,
            locale: state.currentLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode ==
                    deviceLocale?.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            onGenerateRoute: AppGenerateRoutes.onGenerate,
            initialRoute: initialRoute, // Use the dynamic initial route
          );
        },
      ),
    );
  }
}
