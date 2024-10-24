import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smarthome_iot/core/routes/app_routes.dart';
import 'package:smarthome_iot/features/home/domain/entities/room.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/icons/app_icons.dart';

class RoomSession extends StatefulWidget {
  final String iconRoom;
  final Room room;
  const RoomSession({
    super.key,
    required this.iconRoom,
    required this.room,
  });

  @override
  State<RoomSession> createState() => _RoomSessionState();
}

class _RoomSessionState extends State<RoomSession> {
  bool isAction = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.backgroundColor,
      ),
      child: isAction
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      padding: const EdgeInsets.all(8),
                      decoration: const ShapeDecoration(
                        color: AppColors.circleBackground,
                        shape: OvalBorder(),
                      ),
                      child: SvgPicture.asset(
                        widget.iconRoom, // Use the icon passed from HomeRoutes
                        color: AppColors.iconPrimaryColor,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.room.name,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          widget.room.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.textSecondarColor),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isAction = !isAction;
                        });
                      },
                      icon: const Icon(
                        Icons.keyboard_control,
                        color: AppColors.iconPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      backgroundColor:
                          AppColors.buttonUpdateColor, // Set background color
                    ),
                    onPressed: () => Navigator.pushNamed(
                        context, AppRoutes.entry_point,
                        arguments: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(AppIcons.screwdriver_wrench_solid),
                        Text(
                          "Update",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimaryColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      backgroundColor:
                          AppColors.buttonDeleteColor, // Set background color
                    ),
                    onPressed: () {
                      // Add functionality here
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(AppIcons.trash_can_solid),
                        Text(
                          "Delete",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimaryColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
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
    );
  }
}
