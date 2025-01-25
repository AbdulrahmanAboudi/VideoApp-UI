import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_app/core/constants/assets/app_images.dart';
import 'package:flutter_video_app/screens/chapters/view_model/chapter_screen_controller.dart';
import 'package:get/get.dart';

class ChaptersSidebar extends StatelessWidget {
  const ChaptersSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChapterScreenController>(
      builder: (controller) {
        if (controller.showingSubsections) {
          return _buildSubsectionsSidebar(controller);
        }
        return _buildMainSidebar(controller);
      },
    );
  }

  Widget _buildMainSidebar(ChapterScreenController controller) {
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
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: controller.sidebarScrollController,
              child: Column(
                children: List.generate(
                  controller.chapters.length,
                  (chapterIndex) {
                    final chapter = controller.chapters[chapterIndex];
                    final sections =
                        chapter['sections'] as List<Map<String, dynamic>>;
                    return _buildChapterSection(
                      chapter['title'] as String,
                      sections,
                      chapterIndex,
                      controller,
                    );
                  },
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.keyboard_double_arrow_down,
              color: Colors.grey,
            ),
            onPressed: controller.scrollToBottom,
          ),
        ],
      ),
    );
  }

  Widget _buildSubsectionsSidebar(ChapterScreenController controller) {
    final subsections = controller.getCurrentSubsections();
    return Container(
      width: 65.w,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: controller.goBackToVideos,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: controller.sidebarScrollController,
              child: Column(
                children: subsections.asMap().entries.map((entry) {
                  final index = entry.key;
                  final subsection = entry.value;
                  final isSelected =
                      controller.selectedVideo?['currentSubsection'] ==
                          subsection;
                  return GestureDetector(
                    onTap: () => controller.selectSubsection(subsection),
                    child: _buildSectionItem(
                      {'title': subsection, 'status': 'Unwatched'},
                      isSelected,
                      controller,
                      isLastItem: index == subsections.length - 1,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_double_arrow_down,
                color: Colors.grey,
              ),
              onPressed: controller.scrollToBottom,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterSection(
    String chapterText,
    List<Map<String, dynamic>> sections,
    int chapterIndex,
    ChapterScreenController controller,
  ) {
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
                    fontFamily: 'Aboreto',
                  ),
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
                final section =
                    Map<String, dynamic>.from(sections[sectionIndex]);
                section['status'] =
                    controller.getSectionStatus(chapterIndex, sectionIndex);

                final isSelected = controller
                            .selectedSection?['chapterIndex'] ==
                        chapterIndex &&
                    controller.selectedSection?['sectionIndex'] == sectionIndex;

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.selectSection(chapterIndex, sectionIndex);
                      },
                      child: _buildSectionItem(
                        section,
                        isSelected,
                        controller,
                        isLastItem: sectionIndex == sections.length - 1,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusImage({
    required String status,
    bool isSelected = false,
    bool isLastItem = false,
  }) {
    double size = 17.w;
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: status == 'Completed'
                ? Colors.indigoAccent
                : Colors.transparent,
            borderRadius: BorderRadius.circular(size / 2),
            border: status == 'Uncompleted'
                ? Border.all(color: Colors.indigoAccent, width: 4.sp)
                : status == 'Unwatched'
                    ? Border.all(
                        color: Colors.grey.withOpacity(0.3), width: 2.sp)
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
        ),
        if (!isLastItem)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 2.w,
            height: isSelected ? 50.h : 40.h,
            margin: EdgeInsets.only(top: 4.h),
            color: isSelected ? Colors.red : Colors.grey.withOpacity(0.3),
          ),
      ],
    );
  }

  Widget _buildSectionItem(
    Map<String, dynamic> section,
    bool isSelected,
    ChapterScreenController controller, {
    bool isLastItem = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusImage(
            status: section['status']!,
            isSelected: isSelected,
            isLastItem: isLastItem,
          ),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              section['title']!,
              style: TextStyle(
                fontSize: 16.sp,
                decoration:
                    isSelected ? TextDecoration.underline : TextDecoration.none,
                decorationColor: isSelected ? Colors.red : null,
                decorationThickness: isSelected ? 2.0 : null,
                fontFamily: 'Aboreto',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
