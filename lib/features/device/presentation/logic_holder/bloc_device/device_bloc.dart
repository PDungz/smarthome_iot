import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smarthome_iot/core/services/websocket_service.dart';
import 'package:smarthome_iot/features/device/domain/entities/device.dart';
import 'package:smarthome_iot/features/device/domain/repositories/device_repository.dart';

import '../../../../../core/enums/status_state.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceRepository deviceRepository;
  final WebSocketService webSocketService;

  DeviceBloc(this.deviceRepository, this.webSocketService)
      : super(DeviceLoading()) {
    on<LoadDevice>(_onLoadDevicesByRoomId);
    on<UpdateDevice>(_onUpdateDevice);
    on<LoadDevices>(_onLoadDevices);
  }

  Future<void> _onLoadDevices(
      LoadDevices event, Emitter<DeviceState> emit) async {
    emit(DeviceLoading());

    try {
      final devices = await deviceRepository.getDevices();
      emit(DevicesLoaded(devices: devices ?? []));
    } catch (e) {
      emit(DeviceError(Msg: e.toString()));
    }
  }

  Future<void> _onLoadDevicesByRoomId(
      LoadDevice event, Emitter<DeviceState> emit) async {
    emit(DeviceLoading());

    try {
      final devices = await deviceRepository.getDevicesByRoomId(event.roomId);
      emit(DevicesLoaded(devices: devices ?? []));
    } catch (e) {
      emit(DeviceError(Msg: e.toString()));
    }
  }

  Future<void> _onUpdateDevice(
      UpdateDevice event, Emitter<DeviceState> emit) async {
    final currentState = state;

    emit(const DeviceUpdated(state: StatusState.loading));

    try {
      final success = await deviceRepository.putDevice(event.device);

      if (success) {
        if (currentState is DevicesLoaded) {
          // Cập nhật danh sách thiết bị hiện tại
          final updatedDevices = currentState.devices.map((device) {
            return device.id == event.device.id ? event.device : device;
          }).toList();
          webSocketService.updateDeviceState(
            event.device.type,
            event.device.state,
            event.device.gate,
            event.device.id,
          ); // Truyền các tham số cần thiết
          emit(DevicesLoaded(devices: updatedDevices));
        }

        // Phát lại sự kiện LoadDevice để tải lại danh sách thiết bị
        add(LoadDevice(roomId: event.device.roomID));
        emit(const DeviceUpdated(
            state: StatusState.success, Msg: 'Cập nhật thành công'));
      } else {
        emit(const DeviceUpdated(
            state: StatusState.failure, Msg: 'Cập nhật thất bại'));
      }
    } catch (e) {
      emit(DeviceUpdated(state: StatusState.failure, Msg: e.toString()));
    }
  }
}
