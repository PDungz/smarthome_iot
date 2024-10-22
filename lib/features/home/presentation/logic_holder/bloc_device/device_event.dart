part of 'device_bloc.dart';

abstract class DeviceEvent {}

class LoadDevice extends DeviceEvent {
  final String roomId;
  LoadDevice({
    required this.roomId,
  });
}
