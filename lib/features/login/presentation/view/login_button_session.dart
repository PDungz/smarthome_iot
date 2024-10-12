import 'package:flutter/material.dart';

class LoginButtonSection extends StatelessWidget {
  final void Function()? onPressed;
  final bool isLoading;
  const LoginButtonSection({
    super.key,
    this.onPressed,
    this.isLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12)),
            child: const Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            )));
  }
}
