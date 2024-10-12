import 'package:flutter/material.dart';

class ForgotPasswordSection extends StatelessWidget {
  const ForgotPasswordSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Forgot password?',
          ),
        ),
      ),
    );
  }
}
