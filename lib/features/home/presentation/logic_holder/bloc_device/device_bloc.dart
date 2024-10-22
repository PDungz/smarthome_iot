import 'package:bloc/bloc.dart';
import 'package:smarthome_iot/features/home/domain/repositories/device_repository.dart';

import '../../../../../core/services/logger_service.dart';
import '../../../domain/entities/device.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceRepository deviceRepository;

  DeviceBloc(
    this.deviceRepository,
  ) : super(DeviceInitial()) {
    on<LoadDevice>(_onLoadDevices);
  }

  Future<void> _onLoadDevices(
      LoadDevice event, Emitter<DeviceState> emit) async {
    emit(DeviceLoading());
    try {
      final devices = await deviceRepository.getDevicesById(event.roomId);
      emit(DeviceLoaded(devices: devices ?? [])); // Gọi emit để phát trạng thái
    } catch (e) {
      emit(DeviceError(Msg: e.toString())); // Gọi emit để phát trạng thái lỗi
      printE("Error: $e");
    }
  }
}
