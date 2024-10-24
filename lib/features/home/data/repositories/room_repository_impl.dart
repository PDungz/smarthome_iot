// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:smarthome_iot/features/home/data/data_source/room_remote_datasource.dart';
import 'package:smarthome_iot/features/home/domain/entities/room.dart';
import 'package:smarthome_iot/features/home/domain/repositories/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDatasource remoteDatasource;

  RoomRepositoryImpl({
    required this.remoteDatasource,
  });

  @override
  Future<List<Room>?> getRooms() async {
    return await remoteDatasource.getRooms();
  }
}
