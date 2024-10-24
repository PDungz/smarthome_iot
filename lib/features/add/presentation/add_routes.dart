import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/constants/colors/app_icons.dart';
import 'package:smarthome_iot/features/add/presentation/view/device_session.dart';

import 'view/room_session.dart';

class AddRoutes extends StatelessWidget {
  const AddRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 32),
        child: Column(
          children: [
            RoomSession(iconPath: AppIcons.DOOR, title: 'Room'),
            DeviceSession(
                iconPath: AppIcons.screwdriver_wrench_solid, title: "Device"),
          ],
        ),
      ),
    );
  }
}
