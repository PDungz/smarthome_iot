import 'package:bloc/bloc.dart';
import 'package:smarthome_iot/core/enums/status_state.dart';
import 'package:smarthome_iot/features/room/domain/entities/room.dart';
import 'package:smarthome_iot/features/room/domain/repositories/room_repository.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository roomRepository;

  RoomBloc(this.roomRepository) : super(RoomInitial()) {
    on<LoadRoom>(_onLoadRooms);
    on<PostRoom>(_onPostRoom);
  }

  Future<void> _onLoadRooms(LoadRoom event, Emitter<RoomState> emit) async {
    emit(RoomLoading());
    try {
      final rooms = await roomRepository.getRooms();
      emit(RoomLoaded(rooms: rooms ?? []));
    } catch (e) {
      emit(RoomError(Msg: "Failed to load rooms: ${e.toString()}"));
    }
  }

  Future<void> _onPostRoom(PostRoom event, Emitter<RoomState> emit) async {
    emit(RoomPost(status: StatusState.loading));
    try {
      final success = await roomRepository.postRoom(event.room);
      if (success) {
        emit(RoomPost(
            status: StatusState.success, Msg: "Room added successfully"));
        add(LoadRoom()); // Trigger reloading rooms after a successful post
      } else {
        emit(RoomPost(status: StatusState.failure, Msg: "Failed to add room"));
      }
    } catch (e) {
      emit(
          RoomPost(status: StatusState.failure, Msg: "Error: ${e.toString()}"));
    }
  }

  Future<void> _onPutRoom(PutRoom event, Emitter<RoomState> emit) async {
    emit(RoomPut(status: StatusState.loading));
    try {
      final success = await roomRepository.putRoom(event.room);
      if (success) {
        emit(RoomPut(
            status: StatusState.success, Msg: "Room updated successfully"));
        add(LoadRoom());
      } else {
        emit(
            RoomPut(status: StatusState.failure, Msg: "Failed to update room"));
      }
    } catch (e) {
      emit(
          RoomPost(status: StatusState.failure, Msg: "Error: ${e.toString()}"));
    }
  }
}
