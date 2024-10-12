import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:smarthome_iot/core/common/colors/app_colors.dart';
import 'package:smarthome_iot/features/add/presentation/add_routes.dart';
import 'package:smarthome_iot/features/entry_point/presentation/view/app_bottom_navigation_bar.dart';
import 'package:smarthome_iot/features/home/presentation/home_routes.dart';
import 'package:smarthome_iot/features/notification/presentation/notification_routes.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/Profile.png"),
                          fit: BoxFit.cover, // Keep the image aspect ratio
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Use Expanded to prevent overflow
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Admin",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                          Text(
                            "Monday, 20 Jan", // Update with dynamic date if needed
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: AppColors.textSecondarColor),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings,
                        color: AppColors.iconPrimaryColor,
                        size: 32,
                      ),
                    )
                  ],
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
                            transitionType: SharedAxisTransitionType.horizontal,
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
    );
  }
}
