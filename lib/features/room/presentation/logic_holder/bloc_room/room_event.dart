// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'room_bloc.dart';

abstract class RoomEvent {}

class LoadRoom extends RoomEvent {}

class PostRoom extends RoomEvent {
  final Room room;
  PostRoom({
    required this.room,
  });
}

class PutRoom extends RoomEvent {
  final Room room;
  PutRoom({
    required this.room,
  });
}
