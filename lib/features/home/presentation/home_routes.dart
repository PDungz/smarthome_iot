import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/constants/icons/app_icons.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/features/device/data/repositories/device_repository_impl.dart';
import 'package:smarthome_iot/features/home/presentation/view/temp_hum_gas_session.dart';
import 'package:smarthome_iot/features/home/presentation/view/temp_hum_gas_session_loading.dart';
import 'package:smarthome_iot/features/room/data/repositories/room_repository_impl.dart';
import 'package:smarthome_iot/features/device/presentation/logic_holder/bloc_device/device_bloc.dart';
import 'package:smarthome_iot/features/room/presentation/logic_holder/bloc_room/room_bloc.dart';
import 'package:smarthome_iot/features/home/presentation/view/device_session.dart';
import 'package:smarthome_iot/features/home/presentation/view/device_session_loading.dart';
import 'package:smarthome_iot/features/home/presentation/view/rooms_session_loading.dart';
import 'package:smarthome_iot/features/home/presentation/view/rooms_session.dart';
import 'package:smarthome_iot/features/home/presentation/view/weather_session.dart';
import 'package:smarthome_iot/features/setting/presentation/logic_holder/user_bloc/user_bloc.dart';

import '../../../core/constants/colors/app_colors.dart';
import '../../../core/enums/status_state.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/services/logger_service.dart';
import '../../../core/services/websocket_service.dart';
import '../../device/domain/entities/device.dart';

class HomeRoutes extends StatefulWidget {
  const HomeRoutes({super.key});

  @override
  State<HomeRoutes> createState() => _HomeRoutesState();
}

class _HomeRoutesState extends State<HomeRoutes> {
  late WebSocketService webSocketService;
  late String roomId = ""; // Khởi tạo roomId
  Map<String, dynamic> responseWebSocket = {};
  late String accessKey = "";

  double currentGasValue = 0;
  double currentHumidity = 0;
  double currentTemperature = 0;

  @override
  void initState() {
    super.initState();
    webSocketService = WebSocketService();
    // _initializeWebSocket();
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
  void _initializeWebSocket(String userId) {
    webSocketService.connect(userId);
    webSocketService.stream.listen((event) {
      final newResponse = jsonDecode(event)['data'];

      // accessKey ??= newResponse['ip'];
      // printE("WebSocket Response: $newResponse");
      // printS(
      //     "WebSocket Response: ${newResponse['gas_value']} -- ${newResponse['humidity']} -- ${newResponse['temperature']}");

      // Sử dụng toán tử ?? để xử lý giá trị null và gán giá trị mặc định nếu cần
      double newGasValue =
          (newResponse['gas_value'] as num?)?.toDouble() ?? currentGasValue;
      double newHumidity =
          (newResponse['humidity'] as num?)?.toDouble() ?? currentHumidity;
      double newTemperature =
          (newResponse['temperature'] as num?)?.toDouble() ??
              currentTemperature;

      // Kiểm tra sự khác biệt giữa các giá trị hiện tại và giá trị mới
      if (currentGasValue != newGasValue ||
          currentHumidity != newHumidity ||
          currentTemperature != newTemperature) {
        // printE("WebSocket Response -------: $responseWebSocket");

        setState(() {
          // Cập nhật giá trị nếu có sự thay đổi
          accessKey = newResponse['accessKey'];
          currentGasValue = newGasValue;
          currentHumidity = newHumidity;
          currentTemperature = newTemperature;
          responseWebSocket = newResponse; // Cập nhật WebSocket response
          printE("WebSocket Response -------: $responseWebSocket");
        });
      }
    });
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
                ..add(LoadRooms()),
        ),
        BlocProvider<DeviceBloc>(
          create: (context) => DeviceBloc(
              DeviceRepositoryImpl(remoteDatasource: getIt()),
              webSocketService,
              getIt())
            ..add(LoadDeviceByRoomId(roomId: roomId)),
        ),
        // BlocProvider<WebsocketBloc>(
        //   create: (context) => WebsocketBloc(
        //       UserRepositoryImpl(userRemoteDataSource: getIt()),
        //       webSocketService)
        //     ..add(SensorDataWebsocket()),
        // )
        // BlocProvider<UserBloc>(
        //   create: (context) =>
        //       UserBloc(UserRepositoryImpl(userRemoteDataSource: getIt())),
        // )
      ],
      child: BlocConsumer<DeviceBloc, DeviceState>(
        listener: (context, state) {
          if (state is DeviceDeleted) {
            if (state.state == StatusState.success) {
              _showDialog("Success", "Device deleted succcessfully");
            } else if (state.state == StatusState.failure) {
              _showDialog("Error", state.message ?? "Failed to delete device");
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  const SliverToBoxAdapter(child: WeatherSession()),
                  // SliverToBoxAdapter(
                  //     child: BlocBuilder<WebsocketBloc, WebsocketState>(
                  //   builder: (context, state) {
                  //     if (state is WebsocketLoading) {
                  //       return const Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     } else if (state is SensorDataLoaded) {
                  //       return TempHumGasSession(
                  //         responseWebSocket: responseWebSocket,
                  //       );
                  //     }
                  //     return const SizedBox();
                  //   },
                  // )),
                  SliverToBoxAdapter(
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoading) {
                          return const TempHumGasSessionLoading();
                        } else if (state is UserLoaded) {
                          _initializeWebSocket(state.user.id);
                          return TempHumGasSession(
                              responseWebSocket: responseWebSocket);
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 4)),
                  // Hiển thị danh sách phòng
                  SliverToBoxAdapter(
                    child: BlocBuilder<RoomBloc, RoomState>(
                      builder: (context, state) {
                        if (state is RoomLoading) {
                          return const RoomsSessionLoading();
                        } else if (state is RoomsLoaded) {
                          return RoomsSession(
                            rooms: state.rooms,
                            onRoomSelected: (String selectedRoomId) {
                              // Cập nhật roomId và gọi LoadDevice với roomId mới
                              setState(() {
                                roomId = selectedRoomId; // Cập nhật roomId
                              });
                              context.read<DeviceBloc>().add(LoadDeviceByRoomId(
                                  roomId: roomId)); // Gọi LoadDevice
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
                      } else if (state is DevicesLoaded) {
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
                                'KLAXON': AppIcons.KLAXON,
                                'AIR_CONDITIONER': AppIcons.FAN
                              };
                              final device = state.devices[index];
                              return DeviceSession(
                                id: device.id,
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
                                  context.read<DeviceBloc>().add(UpdateDevice(
                                      device: updatedDevice,
                                      accessKey: accessKey));
                                },
                              );
                            },
                            childCount: state.devices.length,
                          ),
                        );
                      } else if (state is DeviceError) {
                        return SliverToBoxAdapter(
                          child: Center(child: Text("Error: ${state.message}")),
                        );
                      }
                      return const SliverToBoxAdapter(child: SizedBox());
                    },
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppColors.textPrimaryColor),
          ),
          content: Text(
            message,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.textSecondarColor),
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.entry_point,
                arguments: [0, ""],
              ),
            ),
          ],
        );
      },
    );
  }
}
