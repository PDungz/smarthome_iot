import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/common/colors/app_colors.dart';

class UsernamePasswordSesion extends StatefulWidget {
  final TextEditingController phoneNumberTexController;
  final TextEditingController passwordTextController;
  final String notification;

  const UsernamePasswordSesion(
      {super.key,
      required this.phoneNumberTexController,
      required this.passwordTextController,
      required this.notification});

  @override
  State<UsernamePasswordSesion> createState() => _UsernamePasswordSesionState();
}

class _UsernamePasswordSesionState extends State<UsernamePasswordSesion> {
  bool onShowPassword = true;

  _onCheckPassword() {
    setState(() {
      onShowPassword = !onShowPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.phoneNumberTexController,
          decoration: const InputDecoration(
            hintText: "Phone Number",
            prefixIcon: Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            // Basic validation logic
            if (value == null || value.isEmpty) {
              return 'Please enter a phone number';
            } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
              return 'Enter a valid 10-digit phone number';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: widget.passwordTextController,
          obscureText: onShowPassword,
          decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: onShowPassword
                ? IconButton(
                    icon: const Icon(
                      Icons.visibility_off,
                      color: AppColors.iconPrimaryColor,
                    ),
                    onPressed: _onCheckPassword,
                  )
                : IconButton(
                    icon: const Icon(
                      Icons.visibility,
                      color: AppColors.iconPrimaryColor,
                    ),
                    onPressed: _onCheckPassword,
                  ),
          ),
          validator: (value) {
            // Basic password validation
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            return null;
          },
        ),
        // Display notification below the password field
        const SizedBox(height: 4),
        Text(
          widget.notification,
          style: TextStyle(
            color: widget.notification.contains('successful')
                ? Colors.green
                : Colors.red,
          ),
        ),
      ],
    );
  }
}
