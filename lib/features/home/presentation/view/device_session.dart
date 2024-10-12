import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smarthome_iot/core/common/colors/app_colors.dart';
import 'package:smarthome_iot/core/common/icons/app_icons.dart';

class DeviceSession extends StatefulWidget {
  final String iconDevice;
  final String device;
  final String decs;
  final bool isActive; // This controls the switch state
  final Function(bool) onToggle; // Callback to toggle switch from HomeRoutes

  const DeviceSession({
    super.key,
    required this.iconDevice,
    required this.device,
    required this.decs,
    required this.isActive,
    required this.onToggle,
  });

  @override
  State<DeviceSession> createState() => _DeviceSessionState();
}

class _DeviceSessionState extends State<DeviceSession> {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        widget
                            .iconDevice, // Use the icon passed from HomeRoutes
                        color: AppColors.iconPrimaryColor,
                      ),
                    ),
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
                const SizedBox(height: 24),
                Text(
                  widget.device,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  widget.decs,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: AppColors.textSecondarColor),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.isActive ? "On" : "Off",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: widget.isActive
                                ? AppColors.textPrimaryColor
                                : AppColors.textSecondarColor,
                          ),
                    ),
                    Switch(
                      value: widget.isActive, // Controlled by HomeRoutes
                      onChanged:
                          widget.onToggle, // Triggers callback in HomeRoutes
                      activeColor: Colors.white,
                      activeTrackColor: Colors.black,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey,
                    ),
                  ],
                ),
              ],
            )
          : InkWell(
              onTap: () {
                setState(() {
                  isAction = !isAction;
                });
              },
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 208,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.buttonUpdateColor, // Set background color
                      ),
                      onPressed: () {
                        // Add functionality here
                      },
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
                    width: 208,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
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
                ],
              ),
            ),
    );
  }
}
