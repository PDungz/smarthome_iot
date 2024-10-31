import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';
import 'text_field_session.dart';

class TextFieldFormSession extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController phoneNumberTexController;
  final TextEditingController passwordTextController;
  final TextEditingController confirmPasswordTextController;

  const TextFieldFormSession({
    super.key,
    required this.fullNameController,
    required this.phoneNumberTexController,
    required this.passwordTextController,
    required this.confirmPasswordTextController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldSession(
          fieldName: "Full Name",
          textEditingController: fullNameController,
          validator: Validators.requirdWithFieldName('Full Name').call,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        const SizedBox(height: 8),
        TextFieldSession(
          fieldName: "Phone number",
          textEditingController: phoneNumberTexController,
          validator: Validators.phoneNumber.call,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        const SizedBox(height: 8),
        TextFieldSession(
          fieldName: "Password",
          textEditingController: passwordTextController,
          validator: Validators.password.call, // Add password validator
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        const SizedBox(height: 8),
        TextFieldSession(
          fieldName: "Confirm password",
          textEditingController: confirmPasswordTextController,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          validator: (value) {
            if (value != passwordTextController.text) {
              return "Passwords do not match";
            }
            return null;
          }, // Add confirm password validator
        ),
      ],
    );
  }
}
