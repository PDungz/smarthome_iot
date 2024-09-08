import 'package:flutter/cupertino.dart';
import '/core/constants/app_colors.dart';
import '/core/constants/app_defaults.dart';
import '/core/constants/app_images.dart';

class HomeWeather extends StatelessWidget {
  const HomeWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDefaults.margin),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(147, 192, 184, 211),
          borderRadius: AppDefaults.borderRadius,
        ),
        height: MediaQuery.of(context).size.height * 0.15,
        child: Padding(
          padding: const EdgeInsets.all(AppDefaults.margin),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    const Text(
                      "Nhiệt độ: 25 C",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: AppColors.primary),
                    ),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              16), // Apply borderRadius to the image
                          child: Image.asset(
                            AppImages.clear,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )
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
