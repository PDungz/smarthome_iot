// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:smarthome_iot/features/device/data/model/device_model.dart';
import 'package:smarthome_iot/features/device/domain/entities/device.dart';
import 'package:smarthome_iot/features/login/domain/repositories/token_repository.dart';

import '../../../../core/services/logger_service.dart';

abstract class DeviceRemoteDatasource {
  Future<List<Device>?> getDevices();
  Future<List<Device>?> getDevicesByRoomId(String roomId);
  Future<bool> putDevice(Device device);
}

class DeviceRemoteDatasourceImpl implements DeviceRemoteDatasource {
  final Dio dio;
  final TokenRepository tokenRepository;

  DeviceRemoteDatasourceImpl({
    required this.dio,
    required this.tokenRepository,
  });

  @override
  Future<List<Device>?> getDevices() async {
    try {
      final accessToken = await tokenRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception("Token truy cập không tồn tại");
      }
      final response = await dio.get('/device/get-by-user',
          options: Options(headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          }));

      final List<dynamic> deviceJson = response.data['devices'];
      return deviceJson.map((json) => DeviceModel.fromJson(json)).toList();
    } on DioException catch (e) {
      printE(
          "[DioException] loại lỗi: ${e.type}, thông điệp lỗi: ${e.message}");
    } catch (e) {
      printE("Lỗi không xác định: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<List<Device>?> getDevicesByRoomId(String roomId) async {
    try {
      final accessToken = await tokenRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception("Token truy cập không tồn tại");
      }
      final response = await dio.get('/device/get-by-room/$roomId',
          options: Options(headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          }));

      final List<dynamic> deviceJson = response.data['devices'];
      return deviceJson.map((json) => DeviceModel.fromJson(json)).toList();
    } on DioException catch (e) {
      printE(
          "[DioException] loại lỗi: ${e.type}, thông điệp lỗi: ${e.message}");
    } catch (e) {
      printE("Lỗi không xác định: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<bool> putDevice(Device device) async {
    try {
      final accessToken = await tokenRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception("Token truy cập không tồn tại");
      }

      final reponse = await dio.put(
        '/device/update/${device.id}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'name': device.name,
          'description': device.description,
          'state': device.state,
          'type': device.type,
          'gate': device.gate,
          'roomID': device.roomID,
          'userID': device.userID,
        },
      );
      return reponse.statusCode == 200;
    } on DioException catch (e) {
      printE(
          "[DioException] loại lỗi: ${e.type}, thông điệp lỗi: ${e.message}");
      return false;
    } catch (e) {
      printE("Lỗi không xác định: ${e.toString()}");
      return false;
    }
  }
}
