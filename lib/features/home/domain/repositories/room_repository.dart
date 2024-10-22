import 'package:smarthome_iot/features/home/domain/entities/room.dart';

abstract class RoomRepository {
  Future<List<Room>?> getRooms();
}
