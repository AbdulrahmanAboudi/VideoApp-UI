import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_app/core/constants/assets/app_images.dart';
import 'package:flutter_video_app/screens/chapters/components/widgets/video_card_widget_body.dart';

class VideoCardWidget extends StatelessWidget {
  const VideoCardWidget({
    super.key,
    this.isSeries = false,
    required this.title,
    required this.status,
    required this.category,
    required this.onPressed,
    this.thumbnail,
  });

  final bool? isSeries;
  final String title;
  final String status;
  final String category;
  final VoidCallback onPressed;
  final String? thumbnail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        constraints: BoxConstraints(maxHeight: 260.h),
        width: 317,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Image.asset(
              thumbnail ?? AppImages.testImage,
            ),
            customVideoCardWidgetBody(title, status, category),
          ],
        ),
      ),
    );
  }
}
