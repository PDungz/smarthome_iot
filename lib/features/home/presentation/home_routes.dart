import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/constants/icons/app_icons.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/features/home/data/repositories/device_repository_impl.dart';
import 'package:smarthome_iot/features/home/data/repositories/room_repository_impl.dart';
import 'package:smarthome_iot/features/home/presentation/logic_holder/bloc_device/device_bloc.dart';
import 'package:smarthome_iot/features/home/presentation/logic_holder/bloc_room/room_bloc.dart';
import 'package:smarthome_iot/features/home/presentation/view/device_session.dart';
import 'package:smarthome_iot/features/home/presentation/view/device_session_loading.dart';
import 'package:smarthome_iot/features/home/presentation/view/rooms_session_loading.dart';
import 'package:smarthome_iot/features/home/presentation/view/rooms_session.dart';
import 'package:smarthome_iot/features/home/presentation/view/temperature_session.dart';

import '../../../core/services/websocket_service.dart';
import '../domain/entities/device.dart';

class HomeRoutes extends StatefulWidget {
  const HomeRoutes({super.key});

  @override
  State<HomeRoutes> createState() => _HomeRoutesState();
}

class _HomeRoutesState extends State<HomeRoutes> {
  String temperature = "";
  String humidity = "";
  final webSocketService = WebSocketService();
  late String roomId = "66fe124019e1814a28fe110d"; // Khởi tạo roomId

  @override
  void initState() {
    super.initState();
  }

  void _onRoomSelected(String selectedRoomId) {
    print(selectedRoomId);
    setState(() {
      roomId = selectedRoomId; // Cập nhật roomId sau khi thêm event LoadDevice
    });
  }

  void _toggleDevice(bool value, Device device) {
    // Thêm logic để bật/tắt thiết bị
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RoomBloc>(
          create: (context) =>
              RoomBloc(RoomRepositoryImpl(remoteDatasource: getIt()))
                ..add(LoadRoom()),
        ),
        BlocProvider<DeviceBloc>(
          create: (context) => DeviceBloc(
              DeviceRepositoryImpl(remoteDatasource: getIt()), webSocketService)
            ..add(LoadDevice(roomId: roomId)),
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              const SliverToBoxAdapter(
                  child: TemperatureSession(
                      temperature: "100°C", humidity: "100%")),
              const SliverToBoxAdapter(child: SizedBox(height: 4)),
              // Hiển thị danh sách phòng
              SliverToBoxAdapter(
                child: BlocBuilder<RoomBloc, RoomState>(
                  builder: (context, state) {
                    if (state is RoomLoading) {
                      return const RoomsSessionLoading();
                    } else if (state is RoomLoaded) {
                      return RoomsSession(
                        rooms: state.rooms,
                        onRoomSelected: (String selectedRoomId) {
                          // Cập nhật roomId và gọi LoadDevice với roomId mới
                          setState(() {
                            roomId = selectedRoomId; // Cập nhật roomId
                          });
                          context.read<DeviceBloc>().add(
                              LoadDevice(roomId: roomId)); // Gọi LoadDevice
                        },
                      );
                    } else if (state is RoomError) {
                      return Center(child: Text("Error: ${state.Msg}"));
                    }
                    return const SizedBox();
                  },
                ),
              ),
              // Hiển thị danh sách thiết bị dựa trên roomId đã chọn
              BlocBuilder<DeviceBloc, DeviceState>(
                builder: (context, state) {
                  if (state is DeviceLoading) {
                    // Hiển thị loading khi đang tải thiết bị
                    return SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return const DeviceSessionLoading();
                        },
                        childCount: 6,
                      ),
                    );
                  } else if (state is DeviceLoaded) {
                    // Kiểm tra danh sách thiết bị có trống không
                    if (state.devices.isEmpty) {
                      return const SliverToBoxAdapter(
                          child: Center(child: Text("No devices found")));
                    }
                    return SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          Map icons = {
                            'LIGHT': AppIcons.LIGHT,
                            'FAN': AppIcons.FAN,
                            'SERVO': AppIcons.DOOR,
                            'KLAXON': AppIcons.KLAXON
                          };
                          final device = state.devices[index];
                          return DeviceSession(
                            iconDevice: icons[device.type],
                            device: device.name,
                            decs: device.description,
                            isActive: device.state == 'ON',
                            onToggle: (value) {
                              final updatedDevice = device.copyWith(
                                state: value
                                    ? 'ON'
                                    : 'OFF', // Toggle giữa ON và OFF
                              );
                              context
                                  .read<DeviceBloc>()
                                  .add(UpdateDevice(device: updatedDevice));
                            },
                          );
                        },
                        childCount: state.devices.length,
                      ),
                    );
                  } else if (state is DeviceError) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text("Error: ${state.Msg}")),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox());
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }
}
