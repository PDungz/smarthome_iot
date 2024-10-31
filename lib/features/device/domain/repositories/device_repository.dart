import 'package:smarthome_iot/features/device/domain/entities/device.dart';

abstract class DeviceRepository {
  Future<List<Device>?> getDevices();
  Future<List<Device>?> getDevicesByRoomId(String roomId);
  Future<bool> putDevice(Device device);
}
