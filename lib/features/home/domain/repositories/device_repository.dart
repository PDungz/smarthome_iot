import 'package:smarthome_iot/features/home/domain/entities/device.dart';

abstract class DeviceRepository {
  Future<List<Device>?> getDevicesById(String roomId);
  Future<bool> updateDevice(Device device);
}
