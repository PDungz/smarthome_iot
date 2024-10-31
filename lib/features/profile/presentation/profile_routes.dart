import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/colors/app_colors.dart';
import '../../../core/enums/status_state.dart';
import '../../../core/services/injection_container.dart';
import '../../entry_point/data/repository/user_repository_impl.dart';
import 'logic_holder/user_bloc/user_bloc.dart';
import 'views/text_field_form_session.dart';

class ProfileRoutes extends StatefulWidget {
  const ProfileRoutes({super.key});

  @override
  State<ProfileRoutes> createState() => _ProfileRoutesState();
}

class _ProfileRoutesState extends State<ProfileRoutes> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  late final TextEditingController fullNameController;
  late final TextEditingController phoneNumberTexController;
  late final TextEditingController passwordTextController;
  late final TextEditingController confirmPasswordTextController;

  @override
  void initState() {
    fullNameController = TextEditingController();
    phoneNumberTexController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 56),
          child: Center(child: Text('Profile account')),
        ),
      ),
      body: BlocProvider<UserBloc>(
        create: (context) =>
            UserBloc(UserRepositoryImpl(userRemoteDataSource: getIt()))
              ..add(LoadUser()),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserUpdated && state.status == StatusState.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Center(
                        child: Text(
                  'User updated successfully!',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.green),
                ))),
              );
              BlocProvider.of<UserBloc>(context).add(LoadUser());
            } else if (state is UserUpdated &&
                state.status == StatusState.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Center(
                        child: Text(
                  'Failed to update user',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.green),
                ))),
              );
            }
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserLoaded) {
              fullNameController.text = state.user.fullName;
              phoneNumberTexController.text = state.user.phoneNumber;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 28),
                          height: 88,
                          width: 88,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Profile.png"),
                              fit: BoxFit.cover, // Keep the image aspect ratio
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Form(
                          key: _keyForm, // Assign the key to the form
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, top: 12, bottom: 16),
                                child: Text(
                                  "Information",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                          color: AppColors.textSecondarColor),
                                ),
                              ),
                              TextFieldFormSession(
                                  fullNameController: fullNameController,
                                  phoneNumberTexController:
                                      phoneNumberTexController,
                                  passwordTextController:
                                      passwordTextController,
                                  confirmPasswordTextController:
                                      confirmPasswordTextController),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_keyForm.currentState!.validate()) {
                                        BlocProvider.of<UserBloc>(context).add(
                                          UpdateUser(
                                            confirmPasswordTextController.text,
                                            user: state.user.copyWith(
                                              fullName: fullNameController.text,
                                              phoneNumber:
                                                  phoneNumberTexController.text,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text("Update"),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberTexController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.dispose();
  }
}