// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:smarthome_iot/features/device/data/data_source/device_remote_datasource.dart';
import 'package:smarthome_iot/features/device/domain/entities/device.dart';
import 'package:smarthome_iot/features/device/domain/repositories/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final DeviceRemoteDatasource remoteDatasource;

  DeviceRepositoryImpl({
    required this.remoteDatasource,
  });

  @override
  Future<List<Device>?> getDevices() async {
    return await remoteDatasource.getDevices();
  }

  @override
  Future<List<Device>?> getDevicesByRoomId(String roomId) async {
    return await remoteDatasource.getDevicesByRoomId(roomId);
  }

  @override
  Future<bool> putDevice(Device device) async {
    return await remoteDatasource.putDevice(device);
  }
}
