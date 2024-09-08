import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/constants/app_colors.dart';
import 'package:smarthome_iot/core/constants/app_defaults.dart';
import 'package:smarthome_iot/core/constants/app_icons.dart';
import 'package:smarthome_iot/view/entry_point/components/bottom_app_bar_item.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onNavTap,
  });

  final int currentIndex;
  final void Function(int) onNavTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: AppDefaults.margin,
      color: AppColors.bottom_color,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppDefaults.margin * 2),
            child: BottomAppBarItem(
              name: 'Home',
              iconLocation: AppIcons.home,
              isAction: currentIndex == 0,
              onTap: () => onNavTap(0),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(AppDefaults.padding * 2),
            child: SizedBox(width: AppDefaults.margin),
          ),
          Padding(
            padding: const EdgeInsets.only(right: AppDefaults.margin * 2),
            child: BottomAppBarItem(
              name: 'Profile',
              iconLocation: AppIcons.profilePerson,
              isAction: currentIndex == 2,
              onTap: () => onNavTap(2),
            ),
          ),
        ],
      ),
    );
  }
}
