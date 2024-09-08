import 'package:flutter/material.dart';
import '/core/components/animated_dots.dart';
import '/core/constants/app_colors.dart';
import '/core/constants/app_defaults.dart';
import '/core/constants/app_images.dart';

class HomeImagesSlider extends StatefulWidget {
  const HomeImagesSlider({super.key});

  @override
  State<HomeImagesSlider> createState() => _HomeImagesSliderState();
}

class _HomeImagesSliderState extends State<HomeImagesSlider> {
  final PageController controller = PageController();
  int currentIndex = 0;

  // Update the list to contain asset paths instead of URLs
  List<String> images = [
    AppImages.house_1,
    AppImages.house_2,
    AppImages.house_3,
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppDefaults.margin - 4),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppDefaults.borderRadius,
      ),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: images.length,
                  onPageChanged: (v) {
                    setState(() {
                      currentIndex = v;
                    });
                  },
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(
                          16), // Apply borderRadius to the image
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Center(
                child: AnimatedDots(
                  totalItems: images.length,
                  currentIndex: currentIndex,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
