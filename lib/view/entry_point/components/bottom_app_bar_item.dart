import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthome_iot/core/constants/app_colors.dart';

class BottomAppBarItem extends StatelessWidget {
  const BottomAppBarItem({
    super.key,
    required this.name,
    required this.iconLocation,
    required this.isAction,
    required this.onTap,
  });

  final String name;
  final String iconLocation;
  final bool isAction;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(
            iconLocation,
            color: isAction
                ? AppColors.buttonIconAction_color
                : AppColors.buttonIcon_color,
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isAction
                      ? AppColors.buttonIconAction_color
                      : AppColors.buttonIcon_color,
                ),
          ),
        ],
      ),
    );
  }
}
