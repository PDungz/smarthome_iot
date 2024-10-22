import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/constants/colors/app_colors.dart';
import 'package:smarthome_iot/core/routes/app_routes.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/features/add/presentation/add_routes.dart';
import 'package:smarthome_iot/features/entry_point/presentation/view/app_bottom_navigation_bar.dart';
import 'package:smarthome_iot/features/entry_point/presentation/view/header_session.dart';
import 'package:smarthome_iot/features/entry_point/presentation/view/header_sessionn_loading.dart';
import 'package:smarthome_iot/features/home/presentation/home_routes.dart';
import 'package:smarthome_iot/features/notification/presentation/notification_routes.dart';
import 'package:smarthome_iot/features/setting/data/repository/user_repository_impl.dart';
import 'package:smarthome_iot/features/setting/domain/repositories/user_repository.dart';
import 'package:smarthome_iot/features/setting/presentation/logic_holder/user_bloc/user_bloc.dart';

import '../../../core/utils/format_date_util.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  int currentIndex = 0;

  List<Widget> pages = [
    const HomeRoutes(),
    const AddRoutes(),
    const NotificationRoutes(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void onBottomNavigationTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) =>
          UserBloc(UserRepositoryImpl(userRemoteDataSource: getIt()))
            ..add(LoadUser()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const HeaderSessionnLoading();
                      } else if (state is UserLoaded) {
                        final String fullName = state.user.fullName;
                        final String toDayTime =
                            DateUtil.formatFullDate(DateTime.now());
                        return HeaderSession(
                          fullName: fullName,
                          toDayTime: toDayTime,
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      // Page Transition Switcher
                      Positioned.fill(
                        child: PageTransitionSwitcher(
                          transitionBuilder:
                              (child, primaryAnimation, secondaryAnimation) {
                            return SharedAxisTransition(
                              animation: primaryAnimation,
                              secondaryAnimation: secondaryAnimation,
                              transitionType:
                                  SharedAxisTransitionType.horizontal,
                              fillColor: AppColors.primaryColor,
                              child: child,
                            );
                          },
                          child: pages[currentIndex],
                        ),
                      ),
                      // Thanh điều hướng dưới cùng
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: AppNavigationBar(
                          currentIndex: currentIndex,
                          onNavTap: onBottomNavigationTap,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
