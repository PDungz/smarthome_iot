import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthome_iot/core/constants/app_colors.dart';
import 'package:smarthome_iot/core/constants/app_images.dart';
import 'package:smarthome_iot/core/routers/app_routes.dart';
import 'package:smarthome_iot/core/utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  final _phoneNumberKey = GlobalKey<FormFieldState>();
  final _passWordKey = GlobalKey<FormFieldState>();

  final _phoneNumberController = TextEditingController();
  final _passWordController = TextEditingController();
  final _phoneNumberFocusNode = FocusNode();
  final _passWordFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneNumberFocusNode.addListener(() {
      if (!_phoneNumberFocusNode.hasFocus) {
        _phoneNumberKey.currentState?.validate();
      }
    });
    _phoneNumberController.addListener(() {
      _phoneNumberKey.currentState?.validate();
    });

    _passWordFocusNode.addListener(() {
      if (!_passWordFocusNode.hasFocus) {
        _passWordKey.currentState?.validate();
      }
    });
    _passWordController.addListener(() {
      _passWordKey.currentState?.validate();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneNumberFocusNode.dispose();
    _passWordFocusNode.dispose();
    super.dispose();
  }

  bool isPasswordShown = false;
  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  onLogin() {
    final bool isFormOkay = _key.currentState?.validate() ?? false;
    if (isFormOkay) {
      Navigator.pushNamed(context, AppRoutes.entrypoint_ui);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                AppImages.background_login,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      color: const Color.fromARGB(200, 243, 237, 247),
                    ),
                    child: Form(
                      key: _key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 24),
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "Smart Home",
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Text("Phone Number"),
                          const SizedBox(height: 8),
                          TextFormField(
                            key: _phoneNumberKey,
                            controller: _phoneNumberController,
                            focusNode: _phoneNumberFocusNode,
                            validator: Validators.phoneNumber.call,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              fillColor: Colors.black,
                            ),
                            textInputAction: TextInputAction.next,
                            onChanged: (value) {
                              _phoneNumberKey.currentState?.validate();
                            },
                          ),
                          const SizedBox(height: 16),
                          const Text("Password"),
                          const SizedBox(height: 8),
                          TextFormField(
                            key: _passWordKey,
                            controller: _passWordController,
                            focusNode: _passWordFocusNode,
                            validator: Validators.password.call,
                            textInputAction: TextInputAction.done,
                            obscureText: !isPasswordShown,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              suffixIcon: Material(
                                color: Colors.transparent,
                                child: isPasswordShown
                                    ? IconButton(
                                        onPressed: onPassShowClicked,
                                        icon: const Icon(CupertinoIcons.eye),
                                      )
                                    : IconButton(
                                        onPressed: onPassShowClicked,
                                        icon: const Icon(
                                            CupertinoIcons.eye_slash),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.button_color,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.all(16),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              onPressed: onLogin,
                              child: const Text("Login"),
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
