import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smarthome_iot/core/common/colors/app_colors.dart';
import 'package:smarthome_iot/core/common/icons/app_icons.dart';

class NotificationRoutes extends StatefulWidget {
  const NotificationRoutes({super.key});

  @override
  State<NotificationRoutes> createState() => _NotificationRoutesState();
}

class _NotificationRoutesState extends State<NotificationRoutes> {
  late final TextEditingController searchTextController;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Search Bar
            TextFormField(
              controller: searchTextController,
              decoration: const InputDecoration(
                hintText: "Searching",
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.iconSecondarColor,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
            const SizedBox(height: 16),
            // Notifications List
            Expanded(
              // Expanded to take available vertical space
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SizedBox(
                              width: 42,
                              height: 42,
                              child:
                                  SvgPicture.asset(AppIcons.lightbulb_regular),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Notification Details
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Living Room",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(),
                              ),
                              const Text("device"),
                              const Text("message"),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
