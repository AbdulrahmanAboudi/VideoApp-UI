import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_app/screens/chapters/components/bars/appbars/custom_chapters_appbar.dart';
import 'package:flutter_video_app/screens/chapters/components/bars/sidebars/chapters_sidebar.dart';
import 'package:flutter_video_app/screens/chapters/components/widgets/video_card_widget.dart';

class ChaptersScreen extends StatelessWidget {
  const ChaptersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customChaptersAppBar(),
      body: Padding(
        padding: EdgeInsets.all(6.w),
        child: Row(
          spacing: 8.w,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ChaptersSidebar(),
            SingleChildScrollView(
              child: Column(
                spacing: 12.h,
                children: List.generate(
                  (10),
                  (index) {
                    return VideoCardWidget(
                      title: 'Title',
                      status: 'Status',
                      category: 'Category',
                      onPressed: () {},
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
