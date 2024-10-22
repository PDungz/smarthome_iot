// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'room_bloc.dart';

abstract class RoomState {}

class RoomLoading extends RoomState {}

class RoomInitial extends RoomState {}

class RoomLoaded extends RoomState {
  final List<Room> rooms;
  RoomLoaded({
    required this.rooms,
  });
}

class RoomError extends RoomState {
  final String Msg;
  RoomError({
    required this.Msg,
  });
}
