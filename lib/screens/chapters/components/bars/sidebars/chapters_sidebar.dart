import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_app/core/constants/assets/app_images.dart';
import 'package:flutter_video_app/screens/chapters/view_model/chapter_screen_controller.dart';
import 'package:get/get.dart';

class ChaptersSidebar extends StatelessWidget {
  ChaptersSidebar({super.key});

  final ChapterScreenController controller = Get.put(ChapterScreenController());

  @override
  Widget build(BuildContext context) {
    final chapters = [
      {
        'title': 'Chapter 1',
        'sections': [
          {'title': '1.1', 'status': 'Completed'},
          {'title': '1.2', 'status': 'Uncompleted'},
          {'title': '1.3', 'status': 'Unwatched'},
          {'title': '1.4', 'status': 'Unwatched'},
          {'title': '1.5', 'status': 'Unwatched'},
        ],
      },
      {
        'title': 'Chapter 2',
        'sections': [
          {'title': '2.1', 'status': 'Uncompleted'},
          {'title': '2.2', 'status': 'Completed'},
          {'title': '2.3', 'status': 'Unwatched'},
          {'title': '2.4', 'status': 'Unwatched'},
          {'title': '2.5', 'status': 'Unwatched'},
        ],
      },
      {
        'title': 'Chapter 3',
        'sections': [
          {'title': '3.1', 'status': 'Completed'},
          {'title': '3.2', 'status': 'Completed'},
          {'title': '3.3', 'status': 'Uncompleted'},
          {'title': '3.4', 'status': 'Unwatched'},
          {'title': '3.5', 'status': 'Unwatched'},
        ],
      },
      {
        'title': 'Chapter 4',
        'sections': [
          {'title': '4.1', 'status': 'Unwatched'},
          {'title': '4.2', 'status': 'Completed'},
          {'title': '4.3', 'status': 'Completed'},
          {'title': '4.4', 'status': 'Uncompleted'},
          {'title': '4.5', 'status': 'Unwatched'},
        ],
      },
      {
        'title': 'Chapter 5',
        'sections': [
          {'title': '5.1', 'status': 'Unwatched'},
          {'title': '5.2', 'status': 'Uncompleted'},
          {'title': '5.3', 'status': 'Completed'},
          {'title': '5.4', 'status': 'Completed'},
          {'title': '5.5', 'status': 'Unwatched'},
        ],
      },
      {
        'title': 'Chapter 6',
        'sections': [
          {'title': '6.1', 'status': 'Completed'},
          {'title': '6.2', 'status': 'Unwatched'},
          {'title': '6.3', 'status': 'Uncompleted'},
          {'title': '6.4', 'status': 'Completed'},
          {'title': '6.5', 'status': 'Completed'},
        ],
      },
    ];

    return Container(
      width: 56.w,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            chapters.length,
            (chapterIndex) {
              final chapter = chapters[chapterIndex];
              final sections = chapter['sections'] as List<Map<String, String>>;
              return _buildChapterSection(
                chapter['title'] as String,
                sections,
                chapterIndex,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildChapterSection(String chapterText,
      List<Map<String, String>> sections, int chapterIndex) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 62.h,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.leafTestImage,
                  width: 12.55.w,
                  height: 11.4.h,
                ),
                Text(
                  chapterText,
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Aboreto'),
                  overflow: TextOverflow.visible,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            children: List.generate(
              sections.length,
              (sectionIndex) {
                final section = sections[sectionIndex];
                return GestureDetector(
                  onTap: () {
                    controller.selectSection(chapterIndex, sectionIndex);
                  },
                  child: GetBuilder<ChapterScreenController>(
                    builder: (controller) {
                      final isSelected =
                          controller.selectedSection?['chapterIndex'] ==
                                  chapterIndex &&
                              controller.selectedSection?['sectionIndex'] ==
                                  sectionIndex;
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    _buildStatusImage(
                                        status: section['status']!),
                                    if (sectionIndex < sections.length - 1)
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        width: 2.w,
                                        height: isSelected ? 40.h : 25.h,
                                        color: isSelected
                                            ? Colors.red
                                            : Colors.indigoAccent
                                                .withOpacity(0.3),
                                      ),
                                  ],
                                ),
                                Text(
                                  section['title']!,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      decoration: isSelected
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                      decorationColor:
                                          isSelected ? Colors.red : null,
                                      decorationThickness:
                                          isSelected ? 2.0 : null,
                                      fontFamily: 'Aboreto'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusImage({required String status}) {
    double size = 17.w;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: status == 'Completed' ? Colors.indigoAccent : Colors.transparent,
        borderRadius: BorderRadius.circular(size / 2),
        border: status == 'Uncompleted'
            ? Border.all(color: Colors.indigoAccent, width: 4.sp)
            : status == 'Unwatched'
                ? Border.all(color: Colors.grey.withOpacity(0.3), width: 2.sp)
                : null,
      ),
      child: Center(
        child: status == 'Completed'
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 12,
              )
            : null,
      ),
    );
  }
}
