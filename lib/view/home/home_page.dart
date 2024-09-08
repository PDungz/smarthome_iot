import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/core/constants/app_colors.dart';
import '/core/constants/app_defaults.dart';
import '/core/constants/app_icons.dart';
import '/view/home/components/home_images_slider.dart';
import '/view/home/components/list_room.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: AppDefaults.margin / 2),
              child: SvgPicture.asset(
                AppIcons.home,
                height: 24,
              ),
            ),
            const Text(
              "Smart Home",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: AppColors.header_color,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: Column(
            children: [
              const HomeImagesSlider(),
              const SizedBox(height: 10),
              Align(
                child: Container(
                  height: 2,
                  width: 300,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(124, 57, 30, 114),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: AppDefaults.margin),
                padding: const EdgeInsets.only(left: AppDefaults.padding),
                decoration: BoxDecoration(
                  color: AppColors.background_color,
                  borderRadius: AppDefaults.borderRadius / 2,
                ),
                child: const Row(
                  children: [
                    Text(
                      "Room",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Expanded(
                child: ListRoom(), // Hiển thị danh sách các thẻ phòng
              ),
            ],
          ),
        ),
      ),
    );
  }
}
