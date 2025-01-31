import 'package:flutter/material.dart';
import 'package:flutter_video_app/core/constants/strings/app_strings.dart';
import 'package:flutter_video_app/core/styles/text_styles.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.videoPlayerTitle,
          style: AppTextStyles.h1,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          AppStrings.videoPlayerTitle,
          style: AppTextStyles.h1,
        ),
      ),
    );
  }
}
