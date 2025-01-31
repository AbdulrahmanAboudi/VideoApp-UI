// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_app/core/constants/assets/app_images.dart';
import 'package:flutter_video_app/core/constants/colors/app_colors.dart';
import 'package:flutter_video_app/core/enums/video_status_enum.dart';
import 'package:flutter_video_app/screens/chapters/view_model/chapter_screen_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_video_app/screens/chapters/domain/chapter_model.dart';
import 'package:flutter_video_app/core/styles/text_styles.dart';

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
          color: AppColors.blackColor.withOpacity(0.1),
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
                    return _buildChapterSection(
                      chapter.title,
                      chapter.sections,
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
              color: AppColors.greyColor,
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
          color: AppColors.blackColor.withOpacity(0.1),
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
                    child: _buildSubsectionItem(
                      subsection,
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
                  color: AppColors.greyColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_double_arrow_down,
                color: AppColors.greyColor,
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
    List<ChapterSection> sections,
    int chapterIndex,
    ChapterScreenController controller,
  ) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 62.h,
          decoration: BoxDecoration(
            color: AppColors.blackColor.withOpacity(0.05),
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
                  style: AppTextStyles.caption,
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
    required VideoStatus status,
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
            color: status.isCompleted
                ? AppColors.indigoAccent
                : AppColors.transparent,
            borderRadius: BorderRadius.circular(size / 2),
            border: status.isUncompleted
                ? Border.all(color: AppColors.indigoAccent, width: 4.sp)
                : status.isUnwatched
                    ? Border.all(
                        color: AppColors.greyColor.withOpacity(0.3),
                        width: 2.sp,
                      )
                    : null,
          ),
          child: Center(
            child: status.isCompleted
                ? const Icon(
                    Icons.check,
                    color: AppColors.whiteColor,
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
            color: isSelected
                ? AppColors.red
                : AppColors.greyColor.withOpacity(0.3),
          ),
      ],
    );
  }

  Widget _buildSectionItem(
    ChapterSection section,
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
            status: section.status,
            isSelected: isSelected,
            isLastItem: isLastItem,
          ),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              section.title,
              style: AppTextStyles.withDecoration(
                AppTextStyles.h3,
                underline: isSelected,
                decorationColor: isSelected ? Colors.red : null,
                decorationThickness: isSelected ? 2.0 : null,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubsectionItem(
    String title,
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
            status: controller.getSubsectionStatus(title),
            isSelected: isSelected,
            isLastItem: isLastItem,
          ),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              title,
              style: AppTextStyles.withDecoration(
                AppTextStyles.h3,
                underline: isSelected,
                decorationColor: isSelected ? Colors.red : null,
                decorationThickness: isSelected ? 2.0 : null,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
