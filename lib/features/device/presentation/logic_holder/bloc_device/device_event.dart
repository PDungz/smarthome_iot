part of 'device_bloc.dart';

abstract class DeviceEvent extends Equatable {
  const DeviceEvent();

  @override
  List<Object> get props => [];
}

class LoadDevices extends DeviceEvent {}

class LoadDevice extends DeviceEvent {
  final String? roomId;

  const LoadDevice({this.roomId});

  @override
  List<Object> get props => [roomId ?? ""];
}

class UpdateDevice extends DeviceEvent {
  final Device device;

  const UpdateDevice({required this.device});

  @override
  List<Object> get props => [device];
}
