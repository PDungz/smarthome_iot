import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/common/icons/app_icons.dart';
import 'package:smarthome_iot/features/home/presentation/view/device_session.dart';
import 'package:smarthome_iot/features/home/presentation/view/rooms_session.dart';
import 'package:smarthome_iot/features/home/presentation/view/temperature_session.dart';

import '../domain/device_model.dart';

class HomeRoutes extends StatefulWidget {
  const HomeRoutes({super.key});

  @override
  State<HomeRoutes> createState() => _HomeRoutesState();
}

class _HomeRoutesState extends State<HomeRoutes> {
  String temperature = "";
  String humidity = "";
  List rooms = [
    {
      "_id": "66fe124019e1814a28fe110d",
      "name": "Living room",
      "description": "device",
      "userID": "66fe029e19e1814a28fe10c8",
      "createdAt": "2024-10-03T03:40:48.631Z",
      "updatedAt": "2024-10-03T03:40:48.631Z",
      "__v": 0
    },
    {
      "_id": "66fe124c19e1814a28fe110f",
      "name": "Bed room",
      "description": "device",
      "userID": "66fe029e19e1814a28fe10c8",
      "createdAt": "2024-10-03T03:41:00.819Z",
      "updatedAt": "2024-10-03T03:41:00.819Z",
      "__v": 0
    },
    {
      "_id": "66fe126e19e1814a28fe1111",
      "name": "Kitchen room",
      "description": "device",
      "userID": "66fe029e19e1814a28fe10c8",
      "createdAt": "2024-10-03T03:41:34.539Z",
      "updatedAt": "2024-10-03T03:41:34.539Z",
      "__v": 0
    }
  ];

  List devices = [
    {
      "_id": "66ff9d5e753b7fa8738f3b0c",
      "name": "fan",
      "description": "fan",
      "state": "OFF",
      "type": "FAN",
      "gate": "D6",
      "roomID": "66fe124c19e1814a28fe110f",
      "userID": "66fe029e19e1814a28fe10c8",
      "createdAt": "2024-10-04T07:46:38.286Z",
      "updatedAt": "2024-10-07T03:31:18.870Z",
      "__v": 0
    },
    {
      "_id": "66ff9dce753b7fa8738f3b1f",
      "name": "Light",
      "description": "Light",
      "state": "ON",
      "type": "LIGHT",
      "gate": "D8",
      "roomID": "66fe124c19e1814a28fe110f",
      "userID": "66fe029e19e1814a28fe10c8",
      "createdAt": "2024-10-04T07:48:30.415Z",
      "updatedAt": "2024-10-07T03:30:30.825Z",
      "__v": 0
    },
    {
      "_id": "66ff9ef6753b7fa8738f3b33",
      "name": "Light",
      "description": "Light",
      "state": "OFF",
      "type": "LIGHT",
      "gate": "D0",
      "roomID": "66fe124019e1814a28fe110d",
      "userID": "66fe029e19e1814a28fe10c8",
      "createdAt": "2024-10-04T07:53:26.606Z",
      "updatedAt": "2024-10-07T03:24:13.576Z",
      "__v": 0
    },
    {
      "_id": "66ff9f5d753b7fa8738f3b38",
      "name": "Light",
      "description": "Light",
      "state": "OFF",
      "type": "LIGHT",
      "gate": "D4",
      "roomID": "66fe126e19e1814a28fe1111",
      "userID": "66fe029e19e1814a28fe10c8",
      "createdAt": "2024-10-04T07:55:09.777Z",
      "updatedAt": "2024-10-07T03:24:00.312Z",
      "__v": 0
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onRoomSelected(String selectedRoomId) {
    setState(() {});
  }

  void _toggleDevice(bool value, Device device) {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            const SliverToBoxAdapter(
              child: TemperatureSession(
                temperature: "100°C", // Accessing temperature from nested data
                humidity: "100%", // Accessing humidity from nested data
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 4),
            ),
            SliverToBoxAdapter(
              child: RoomsSession(
                rooms: rooms,
                onRoomSelected: _onRoomSelected, // Pass the callback
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final device = devices[index];
                  return DeviceSession(
                    iconDevice: AppIcons.lightbulb_regular,
                    device: device['name'],
                    decs: device['description'],
                    isActive: device['state'] == 'ON',
                    onToggle: (value) => _toggleDevice(value, device),
                  );
                },
                childCount: devices.length,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }
}
