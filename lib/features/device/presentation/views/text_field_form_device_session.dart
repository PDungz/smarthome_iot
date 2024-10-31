import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';
import 'text_field_device_session.dart';

class TextFieldFormDeviceSession extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionTexController;
  final TextEditingController typeController;
  final TextEditingController gateController;
  const TextFieldFormDeviceSession({
    super.key,
    required this.nameController,
    required this.descriptionTexController,
    required this.typeController,
    required this.gateController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldDeviceSession(
          fieldName: "Name",
          textEditingController: nameController,
          validator: Validators.requirdWithFieldName('Name').call,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        const SizedBox(height: 8),
        TextFieldDeviceSession(
          fieldName: "Description",
          textEditingController: descriptionTexController,
          maxLines: 2,
          validator: Validators.requirdWithFieldName('Description').call,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        const SizedBox(height: 8),
        TextFieldDeviceSession(
          fieldName: "Type",
          textEditingController: typeController,
          validator: Validators.requirdWithFieldName('Type').call,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        const SizedBox(height: 8),
        TextFieldDeviceSession(
          fieldName: "Gate",
          textEditingController: gateController,
          validator: Validators.requirdWithFieldName('Gate').call,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ],
    );
  }
}
