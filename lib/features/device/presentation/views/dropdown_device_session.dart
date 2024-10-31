import 'package:flutter/material.dart';
import 'package:smarthome_iot/features/room/domain/entities/room.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/components/components_dropdown/custom_dropdown.dart';

class DropdownDeviceSession extends StatelessWidget {
  final String? selectedRoomId;
  final List<Room> rooms;
  final ValueChanged<String?> onChanged;

  const DropdownDeviceSession({
    super.key,
    required this.selectedRoomId,
    required this.rooms,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Room:",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.textSecondarColor),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: CustomDropdown<String>(
            selectedItem: selectedRoomId,
            items: rooms.map((room) => room.id).toList(),
            hintText: 'Select room',
            onChanged: onChanged,
            itemLabelBuilder: (id) =>
                rooms.firstWhere((room) => room.id == id).name,
          ),
        ),
      ],
    );
  }
}
