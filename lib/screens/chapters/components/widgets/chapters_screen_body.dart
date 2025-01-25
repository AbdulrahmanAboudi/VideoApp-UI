import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_app/screens/chapters/components/bars/sidebars/chapters_sidebar.dart';
import 'package:flutter_video_app/screens/chapters/components/widgets/video_card_shimmer.dart';
import 'package:flutter_video_app/screens/chapters/components/widgets/video_card_widget.dart';
import 'package:flutter_video_app/screens/chapters/view_model/chapter_screen_controller.dart';
import 'package:flutter_video_app/screens/video_player/screens/video_player_screen.dart';
import 'package:get/get.dart';

class ChaptersScreenBody extends StatelessWidget {
  const ChaptersScreenBody({
    super.key,
    required this.videos,
    required this.showEmptyMessage,
    this.emptyMessage,
  });

  final List<Map<String, dynamic>> videos;
  final bool showEmptyMessage;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChapterScreenController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.all(6.w),
          child: Row(
            spacing: 8.w,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 200.w),
                child: const ChaptersSidebar(),
              ),
              Expanded(
                child: GetBuilder<ChapterScreenController>(
                  builder: (controller) {
                    if (controller.isLoading) {
                      return SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            controller.shimmerCount,
                            (index) => Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: const VideoCardShimmer(),
                            ),
                          ),
                        ),
                      );
                    }

                    if (showEmptyMessage) {
                      return Center(
                        child: Text(
                          emptyMessage ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Aboreto',
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: videos.map(
                          (video) {
                            return VideoCardWidget(
                              isSeries: video['isSeries'] ?? false,
                              title: video['title'] ?? '',
                              status: video['status'] ?? '',
                              category: video['category'] ?? '',
                              onPressed: video['isSeries'] == true
                                  ? () {}
                                  : () =>
                                      Get.to(() => const VideoPlayerScreen()),
                            );
                          },
                        ).toList(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
