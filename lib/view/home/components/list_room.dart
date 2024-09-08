import 'package:flutter/material.dart';
import '/core/constants/app_icons.dart';
import '/view/home/components/card_room.dart';

class ListRoom extends StatelessWidget {
  const ListRoom({super.key});

  final List<Map<String, String>> rooms = const [
    {
      'roomName': 'Living Room',
      'iconName': AppIcons.livingRoom,
      'description': 'Spacious and modern living room with a cozy sofa.',
    },
    {
      'roomName': 'Bedroom',
      'iconName': AppIcons.bedRoom,
      'description': 'Comfortable bedroom with a king-sized bed and wardrobe.',
    },
    {
      'roomName': 'Kitchen',
      'iconName': AppIcons.kitchenRoom,
      'description': 'Fully equipped kitchen with modern appliances.',
    },
    {
      'roomName': 'Toilet',
      'iconName': AppIcons.toiletRoom,
      'description': 'Fully equipped kitchen with modern appliances.',
    },
    {
      'roomName': 'BathRoom',
      'iconName': AppIcons.bathRoom,
      'description': 'Fully equipped kitchen with modern appliances.',
    },
    {
      'roomName': 'Bedroom 2',
      'iconName': AppIcons.bedRoom,
      'description': 'Comfortable bedroom with a king-sized bed and wardrobe.',
    },
    {
      'roomName': 'Bedroom 3',
      'iconName': AppIcons.bedRoom,
      'description': 'Comfortable bedroom with a king-sized bed and wardrobe.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        return CardRoom(
          roomName: room['roomName']!,
          iconName: room['iconName']!,
          description: room['description']!,
          onPressed: () {
            // Xử lý sự kiện khi nhấn vào thẻ phòng
          },
        );
      },
    );
  }
}
