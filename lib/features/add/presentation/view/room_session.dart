import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smarthome_iot/core/constants/colors/app_colors.dart';
import 'package:smarthome_iot/core/constants/icons/app_icons.dart';

import '../../../../core/routes/app_routes.dart';

class RoomSession extends StatefulWidget {
  final String iconPath;
  final String title;

  const RoomSession({
    super.key,
    required this.iconPath,
    required this.title,
  });

  @override
  State<RoomSession> createState() => _RoomSessionState();
}

class _RoomSessionState extends State<RoomSession> {
  bool isAction = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isAction = !isAction;
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: isAction
            ? Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: SvgPicture.asset(
                      widget.iconPath,
                      color: AppColors.iconPrimaryColor,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryColor,
                        ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                        context, AppRoutes.entry_point,
                        arguments: 3),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            AppIcons.search_solid,
                            color: AppColors.backgroundColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text("View",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.backgroundColor)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                        context, AppRoutes.entry_point,
                        arguments: 4),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        backgroundColor: AppColors.buttonUpdateColor),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: SvgPicture.asset(
                            AppIcons.plus_solid,
                            color: AppColors.iconPrimaryColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text("View",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      backgroundColor: Colors.red, // Set background color
                    ),
                    onPressed: () {
                      setState(() {
                        isAction = !isAction;
                      });
                    },
                    child: SvgPicture.asset(
                      AppIcons.close_solid,
                      color: AppColors.primaryColor,
                      height: 20,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
