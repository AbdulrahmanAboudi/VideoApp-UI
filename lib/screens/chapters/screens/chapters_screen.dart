import 'package:flutter/material.dart';
import 'package:flutter_video_app/core/constants/strings/app_strings.dart';
import 'package:flutter_video_app/screens/chapters/components/bars/appbars/custom_chapters_appbar.dart';
import 'package:flutter_video_app/screens/chapters/components/widgets/chapters_screen_body.dart';
import 'package:get/get.dart';
import 'package:flutter_video_app/screens/chapters/view_model/chapter_screen_controller.dart';

class ChaptersScreen extends StatelessWidget {
  const ChaptersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChapterScreenController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customChaptersAppBar(),
      body: GetBuilder<ChapterScreenController>(
        builder: (controller) {
          final videos = controller.currentSectionVideos;

          if (controller.selectedSection == null) {
            return const ChaptersScreenBody(
              videos: [],
              showEmptyMessage: true,
              emptyMessage: AppStrings.selectSection,
            );
          }

          if (videos.isEmpty) {
            controller.showNoVideosSnackbar();

            return const ChaptersScreenBody(
              videos: [],
              showEmptyMessage: true,
              emptyMessage: AppStrings.noVideosAvailable,
            );
          }

          return ChaptersScreenBody(
            videos: videos,
            showEmptyMessage: false,
          );
        },
      ),
    );
  }
}
