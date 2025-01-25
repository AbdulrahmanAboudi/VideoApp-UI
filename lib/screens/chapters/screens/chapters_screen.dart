import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_app/screens/chapters/components/bars/appbars/custom_chapters_appbar.dart';
import 'package:flutter_video_app/screens/chapters/components/bars/sidebars/chapters_sidebar.dart';
import 'package:flutter_video_app/screens/chapters/components/widgets/video_card_widget.dart';
import 'package:flutter_video_app/screens/video_player/screens/video_player_screen.dart';
import 'package:get/get.dart';

class ChaptersScreen extends StatelessWidget {
  const ChaptersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bool isSeries = true;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customChaptersAppBar(),
      body: Padding(
        padding: EdgeInsets.all(6.w),
        child: Row(
          spacing: 8.w,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 200.w),
              child: ChaptersSidebar(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    10,
                    (index) {
                      return VideoCardWidget(
                        isSeries: isSeries,
                        title:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                        status: 'Status',
                        category: 'Category',
                        onPressed: isSeries
                            ? () {}
                            : () => Get.to(() => const VideoPlayerScreen()),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
