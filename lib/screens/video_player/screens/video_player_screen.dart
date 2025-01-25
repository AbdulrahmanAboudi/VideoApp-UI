import 'package:flutter/material.dart';
import 'package:flutter_video_app/core/constants/strings/app_strings.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.videoPlayerTitle,
          style: TextStyle(fontFamily: 'Aboreto'),
        ),
        centerTitle: true,
      ),
    );
  }
}
