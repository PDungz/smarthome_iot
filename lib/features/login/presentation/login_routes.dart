import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';
import 'view/forgot_textbutton_session.dart';
import 'view/login_button_session.dart';
import 'view/username_password_sesion.dart';

class LoginRoutes extends StatefulWidget {
  const LoginRoutes({super.key});

  @override
  State<LoginRoutes> createState() => _LoginRoutesState();
}

class _LoginRoutesState extends State<LoginRoutes> {
  late final TextEditingController phoneNumberTexController;
  late final TextEditingController passwordTextController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String notification = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_login.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 190, 190, 190)
                        .withOpacity(0.98),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: Text(
                              "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 42),
                            ),
                          ),
                        ),
                        UsernamePasswordSesion(
                          phoneNumberTexController: phoneNumberTexController,
                          passwordTextController: passwordTextController,
                          notification: notification,
                        ),
                        const ForgotPasswordSection(),
                        LoginButtonSection(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(
                                  context, AppRoutes.entry_point);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    phoneNumberTexController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    phoneNumberTexController = TextEditingController();
    passwordTextController = TextEditingController();
    super.initState();
  }
}
