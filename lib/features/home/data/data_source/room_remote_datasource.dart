// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:smarthome_iot/core/services/logger_service.dart';
import 'package:smarthome_iot/features/home/data/model/room_model.dart';
import 'package:smarthome_iot/features/home/domain/entities/room.dart';
import '../../../login/domain/repositories/token_repository.dart';

abstract class RoomRemoteDatasource {
  Future<List<Room>?> getRooms();
}

class RoomRemoteDatasourceImpl implements RoomRemoteDatasource {
  final Dio dio;
  final TokenRepository tokenRepository;

  RoomRemoteDatasourceImpl({
    required this.dio,
    required this.tokenRepository,
  });

  @override
  Future<List<Room>?> getRooms() async {
    try {
      // Lấy token truy cập từ repository
      final accessToken = await tokenRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception("Token truy cập không tồn tại");
      }

      final response = await dio.get(
        "/room/get-by-user",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      final List<dynamic> roomJson = response.data['rooms'];

      return roomJson.map((json) => RoomModel.fromJson(json)).toList();
    } on DioException catch (e) {
      printE(
          "[DioException] loại lỗi: ${e.type}, thông điệp lỗi: ${e.message}");
    } catch (e) {
      printE("Lỗi không xác định: ${e.toString()}");
    }
    return null;
  }
}
