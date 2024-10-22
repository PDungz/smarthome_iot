part of 'device_bloc.dart';

abstract class DeviceState {}

class DeviceLoading extends DeviceState {}

class DeviceInitial extends DeviceState {}

class DeviceLoaded extends DeviceState {
  final List<Device> devices;
  DeviceLoaded({
    required this.devices,
  });
}

class DeviceError extends DeviceState {
  final String Msg;
  DeviceError({
    required this.Msg,
  });
}
