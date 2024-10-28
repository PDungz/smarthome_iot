import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';
import 'text_field_room_session.dart';

class TextFieldFormRoomSession extends StatelessWidget {
  final TextEditingController roomController;
  final TextEditingController descriptionTexController;

  const TextFieldFormRoomSession({
    super.key,
    required this.roomController,
    required this.descriptionTexController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldRoomSession(
          fieldName: "Room",
          textEditingController: roomController,
          validator: Validators.requirdWithFieldName('Room').call,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        const SizedBox(height: 8),
        TextFieldRoomSession(
          fieldName: "Description",
          textEditingController: descriptionTexController,
          maxLines: 5,
          validator: Validators.requirdWithFieldName('Description').call,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ],
    );
  }
}
