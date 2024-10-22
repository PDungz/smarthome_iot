import 'package:bloc/bloc.dart';
import 'package:smarthome_iot/features/home/domain/entities/room.dart';
import 'package:smarthome_iot/features/home/domain/repositories/room_repository.dart';

import '../../../../../core/services/logger_service.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository roomRepository;

  RoomBloc(
    this.roomRepository,
  ) : super(RoomInitial()) {
    on<LoadRoom>(_onLoadRooms);
  }

  Future<void> _onLoadRooms(LoadRoom event, Emitter<RoomState> emit) async {
    emit(RoomLoading());
    try {
      final rooms = await roomRepository.getRooms();
      emit(RoomLoaded(rooms: rooms ?? []));
    } catch (e) {
      emit(RoomError(Msg: e.toString()));
      printE("Error: $e");
    }
  }
}
