import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthome_iot/core/apis/dio_client.dart';
import 'package:smarthome_iot/features/home/data/data_source/device_remote_datasource.dart';
import 'package:smarthome_iot/features/home/data/data_source/room_remote_datasource.dart';
import 'package:smarthome_iot/features/home/data/repositories/device_repository_impl.dart';
import 'package:smarthome_iot/features/home/data/repositories/room_repository_impl.dart';
import 'package:smarthome_iot/features/home/domain/repositories/device_repository.dart';
import 'package:smarthome_iot/features/home/domain/repositories/room_repository.dart';
import 'package:smarthome_iot/features/login/data/data_sources/auth_remote_datasource.dart';
import 'package:smarthome_iot/features/login/data/repositories/auth_repository.dart';
import 'package:smarthome_iot/features/login/data/repositories/storage_token_repository.dart';
import 'package:smarthome_iot/features/login/domain/repositories/auth_repository.dart';
import 'package:smarthome_iot/features/login/domain/repositories/token_repository.dart';
import 'package:smarthome_iot/features/notification/data/data_sources/notification_action_remote_datasource.dart';
import 'package:smarthome_iot/features/notification/data/repositories/notification_action_repository_impl.dart';
import 'package:smarthome_iot/features/notification/domain/repositories/notification_action_repository.dart';

import '../../features/entry_point/data/data_source/user_remote_data_source.dart';
import '../../features/entry_point/data/repository/user_repository_impl.dart';
import '../../features/entry_point/domain/repositories/user_repository.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //! Flutter Secure Storage
  getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

  //! Dio Client
  getIt.registerLazySingleton<DioClient>(
      () => DioClient(tokenRepository: getIt()));

  //! Remote Data Source
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(dio: getIt<DioClient>().externalDio),
  );

  getIt.registerLazySingleton<RoomRemoteDatasource>(
    () => RoomRemoteDatasourceImpl(
      dio: getIt<DioClient>().externalDio,
      tokenRepository: getIt<TokenRepository>(),
    ),
  );

  getIt.registerLazySingleton<DeviceRemoteDatasource>(
    () => DeviceRemoteDatasourceImpl(
      dio: getIt<DioClient>().externalDio,
      tokenRepository: getIt<TokenRepository>(),
    ),
  );

  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
        dio: getIt<DioClient>().externalDio,
        tokenRepository: getIt<TokenRepository>()),
  );

  getIt.registerLazySingleton<NotificationActionRemoteDatasource>(
    () => NotificationActionRemoteDatasourceImpl(
        dio: getIt<DioClient>().externalDio,
        tokenRepository: getIt<TokenRepository>()),
  );

  //! Repository
  getIt.registerLazySingleton<TokenRepository>(
    () => StorageTokenRepository(secureStorage: getIt<FlutterSecureStorage>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDatasource: getIt(),
      tokenRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<RoomRepository>(
      () => RoomRepositoryImpl(remoteDatasource: getIt()));

  getIt.registerLazySingleton<DeviceRepository>(
      () => DeviceRepositoryImpl(remoteDatasource: getIt()));

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userRemoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<NotificationActionRepository>(
    () => NotificationActionRepositoryImpl(
        notificationActionRemoteDatasource: getIt()),
  );
}
