import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/constants/icons/app_icons.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/features/home/data/repositories/room_repository_impl.dart';
import 'package:smarthome_iot/features/home/presentation/logic_holder/bloc_room/room_bloc.dart';
import 'package:smarthome_iot/features/room/presentation/views/room_session.dart';
import 'package:smarthome_iot/features/room/presentation/views/room_session_loading.dart';

class ViewRoomRoutes extends StatelessWidget {
  const ViewRoomRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RoomBloc>(
      create: (context) =>
          RoomBloc(RoomRepositoryImpl(remoteDatasource: getIt()))
            ..add(LoadRoom()),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverToBoxAdapter(
              child: BlocBuilder<RoomBloc, RoomState>(
                builder: (context, state) {
                  if (state is RoomLoading) {
                    return SizedBox(
                      width: double.infinity,
                      height: double.maxFinite,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          return const ListTile(
                            title: RoomSessionLoading(),
                          );
                        },
                      ),
                    );
                  } else if (state is RoomLoaded) {
                    return SizedBox(
                      width: double.infinity,
                      height: double.maxFinite,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: state.rooms.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: RoomSession(
                                iconRoom: AppIcons.DOOR,
                                room: state.rooms[index]),
                          );
                        },
                      ),
                    );
                  } else if (state is RoomError) {
                    return Center(child: Text("Error: ${state.Msg}"));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
