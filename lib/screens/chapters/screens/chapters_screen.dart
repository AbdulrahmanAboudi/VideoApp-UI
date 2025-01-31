import 'package:flutter/material.dart';
import 'package:flutter_video_app/core/constants/colors/app_colors.dart';
import 'package:flutter_video_app/core/enums/message_enum.dart';
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
      backgroundColor: AppColors.whiteColor,
      appBar: customChaptersAppBar(),
      body: GetBuilder<ChapterScreenController>(
        builder: (controller) {
          final videos = controller.currentSectionVideos;

          if (controller.selectedSection == null) {
            return const ChaptersScreenBody(
              videos: [],
              showEmptyMessage: true,
              customMessage: CustomMessage.selectSection,
            );
          }

          if (videos.isEmpty) {
            controller.showNoVideosSnackbar();

            return const ChaptersScreenBody(
              videos: [],
              showEmptyMessage: true,
              customMessage: CustomMessage.noVideos,
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
