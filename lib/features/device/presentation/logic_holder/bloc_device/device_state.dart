part of 'device_bloc.dart';

abstract class DeviceState extends Equatable {
  const DeviceState();

  @override
  List<Object> get props => [];
}

class DeviceLoading extends DeviceState {}

class DevicesLoaded extends DeviceState {
  final List<Device> devices;

  const DevicesLoaded({required this.devices});

  @override
  List<Object> get props => [devices];
}

class DeviceUpdated extends DeviceState {
  final StatusState state;
  final String? Msg;

  const DeviceUpdated({required this.state, this.Msg});

  @override
  List<Object> get props => [state, Msg ?? ""];
}

class DeviceError extends DeviceState {
  final String Msg;

  const DeviceError({required this.Msg});

  @override
  List<Object> get props => [Msg];
}
