import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthome_iot/core/constants/app_colors.dart';
import 'package:smarthome_iot/core/constants/app_defaults.dart';
import 'package:smarthome_iot/core/constants/app_icons.dart';
import 'package:smarthome_iot/view/add/add_page.dart';
import 'package:smarthome_iot/view/entry_point/components/app_navigation_bar.dart';
import 'package:smarthome_iot/view/home/home_page.dart';
import 'package:smarthome_iot/view/profile/profile_page.dart';

class EntryPointUi extends StatefulWidget {
  const EntryPointUi({super.key});

  @override
  State<EntryPointUi> createState() => _EntryPointUiState();
}

class _EntryPointUiState extends State<EntryPointUi> {
  int currentIndex = 0;

  onBottomNavigationTap(int index) {
    currentIndex = index;
    setState(() {});
  }

  List<Widget> pages = [const HomePage(), const AddPage(), const ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            fillColor: AppColors.bottom_color,
            child: child,
          );
        },
        duration: AppDefaults.duration,
        child: pages[currentIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onBottomNavigationTap(1);
        },
        shape: const CircleBorder(),
        backgroundColor: AppColors.primary,
        child: SvgPicture.asset(
          AppIcons.add,
          height: 28,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: currentIndex,
        onNavTap: onBottomNavigationTap,
      ),
    );
  }
}
