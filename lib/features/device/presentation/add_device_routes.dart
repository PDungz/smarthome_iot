import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/constants/components/components_shimmer/shimmer_loading.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/features/device/presentation/views/text_field_form_device_session.dart';
import 'package:smarthome_iot/features/room/data/repositories/room_repository_impl.dart';
import 'package:smarthome_iot/features/room/presentation/logic_holder/bloc_room/room_bloc.dart';
import '../../../core/constants/colors/app_colors.dart';
import 'views/dropdown_device_session.dart'; // Import DropdownDeviceSession

class AddDeviceRoutes extends StatefulWidget {
  const AddDeviceRoutes({super.key});

  @override
  State<AddDeviceRoutes> createState() => _AddDeviceRoutesState();
}

class _AddDeviceRoutesState extends State<AddDeviceRoutes> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController descriptionTexController;
  late final TextEditingController typeController;
  late final TextEditingController gateController;

  String? _selectedRoomId;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionTexController = TextEditingController();
    typeController = TextEditingController();
    gateController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RoomBloc>(
      create: (context) =>
          RoomBloc(RoomRepositoryImpl(remoteDatasource: getIt()))
            ..add(LoadRooms()),
      child: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.backgroundColor,
                  ),
                  child: Form(
                    key: _keyForm,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "Add Device",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimaryColor,
                              ),
                        ),
                        const SizedBox(height: 20),
                        // Các trường nhập khác
                        TextFieldFormDeviceSession(
                          nameController: nameController,
                          descriptionTexController: descriptionTexController,
                          typeController: typeController,
                          gateController: gateController,
                        ),
                        // Dropdown chọn phòng
                        const SizedBox(height: 16),
                        BlocBuilder<RoomBloc, RoomState>(
                          builder: (context, state) {
                            if (state is RoomLoading) {
                              return const ShimmerLoading();
                            } else if (state is RoomsLoaded) {
                              final rooms = state.rooms;
                              return DropdownDeviceSession(
                                selectedRoomId: _selectedRoomId,
                                rooms: rooms,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRoomId = value;
                                  });
                                },
                              );
                            }
                            return const ShimmerLoading();
                          },
                        ),

                        const SizedBox(height: 24),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_keyForm.currentState?.validate() ?? false) {
                                // Xử lý khi form hợp lệ với _selectedRoomId
                              }
                            },
                            child: const Text("Thêm"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionTexController.dispose();
    typeController.dispose();
    gateController.dispose();
  }
}
