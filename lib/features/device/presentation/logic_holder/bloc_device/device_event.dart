// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final String esp_ip;
  final Device device;

  const UpdateDevice({
    required this.esp_ip,
    required this.device,
  });

  @override
  List<Object> get props => [device, esp_ip];
}
