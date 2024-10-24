// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:smarthome_iot/features/home/data/data_source/device_remote_datasource.dart';
import 'package:smarthome_iot/features/home/domain/entities/device.dart';
import 'package:smarthome_iot/features/home/domain/repositories/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final DeviceRemoteDatasource remoteDatasource;

  DeviceRepositoryImpl({
    required this.remoteDatasource,
  });

  @override
  Future<List<Device>?> getDevicesById(String roomId) async {
    return await remoteDatasource.getDevicesById(roomId);
  }

  @override
  Future<bool> updateDevice(Device device) async {
    return await remoteDatasource.updateDevice(device);
  }
}
