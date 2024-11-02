import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smarthome_iot/core/constants/colors/app_colors.dart';
import 'package:smarthome_iot/core/constants/icons/app_icons.dart';

class TempHumGasSession extends StatelessWidget {
  final Map<String, dynamic> responseWebSocket;
  const TempHumGasSession({
    super.key,
    required this.responseWebSocket,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3.6,
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: ShapeDecoration(
                color: AppColors.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppIcons.temperature_solid,
                    height: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${responseWebSocket['temperature']}°C",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3.6,
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: ShapeDecoration(
                color: AppColors.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppIcons.droplet_solid,
                    color: Colors.blue[200],
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${responseWebSocket['humidity']}%",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3.6,
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: ShapeDecoration(
                color: AppColors.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppIcons.fire_solid,
                    color: Colors.red[200],
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${responseWebSocket['gas_value']}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
