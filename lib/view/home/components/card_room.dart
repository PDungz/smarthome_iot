import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthome_iot/core/constants/app_colors.dart';
import 'package:smarthome_iot/core/constants/app_defaults.dart';
import 'package:smarthome_iot/core/routers/app_routes.dart';

class CardRoom extends StatelessWidget {
  const CardRoom({
    super.key,
    required this.roomName,
    required this.iconName,
    required this.description,
    required this.onPressed,
  });

  final String roomName;
  final String iconName;
  final String description;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding / 4),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(AppRoutes.device, arguments: roomName);
        },
        child: Card(
          color: AppColors.card_color, // Sử dụng màu đã định nghĩa
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Đảm bảo căn lề trái cho toàn bộ nội dung
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      iconName,
                      width: 68,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      // Đảm bảo mô tả có không gian linh hoạt
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            roomName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description,
                            maxLines:
                                2, // Cho phép mô tả hiển thị tối đa 2 dòng
                            overflow: TextOverflow
                                .ellipsis, // Hiển thị dấu ... nếu mô tả quá dài
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
