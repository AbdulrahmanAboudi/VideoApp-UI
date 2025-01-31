import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_app/core/constants/colors/app_colors.dart';
import 'package:flutter_video_app/core/constants/strings/app_strings.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_app/screens/chapters/domain/video_model.dart';
import 'package:flutter_video_app/core/enums/video_status_enum.dart';
import 'package:flutter_video_app/screens/chapters/domain/chapter_model.dart';

class ChapterScreenController extends GetxController {
  Map<String, dynamic>? selectedSection;
  bool isLoading = false;
  int previousVideoCount = 0;
  Map<String, dynamic>? selectedVideo;
  bool showingSubsections = false;
  bool _hasShownSnackbar = false;
  final ScrollController sidebarScrollController = ScrollController();

  late final List<ChapterModel> chapters;

  @override
  void onInit() {
    super.onInit();
    chapters = [
      ChapterModel(
        title: 'Chapter 1',
        sections: [
          ChapterSection(
            title: '1.1',
            status: VideoStatus.completed,
            videos: [
              VideoModel(
                title: 'Introduction to Section 1.1',
                status: VideoStatus.completed,
                category: 'Basics',
                isSeries: false,
              ),
              VideoModel(
                title: 'Core Concepts of 1.1',
                status: VideoStatus.completed,
                category: 'Fundamentals',
                isSeries: true,
                subsections: [
                  SubsectionModel(
                    title: '1.1.1',
                    videos: [
                      VideoModel(
                        title: 'Part 1 of Series',
                        status: VideoStatus.completed,
                        category: 'Series',
                      ),
                      VideoModel(
                        title: 'Part 2 of Series',
                        status: VideoStatus.completed,
                        category: 'Series',
                      ),
                    ],
                  ),
                  SubsectionModel(
                    title: '1.1.2',
                    videos: [
                      VideoModel(
                        title: 'Advanced Concepts Part 1',
                        status: VideoStatus.completed,
                        category: 'Series',
                      ),
                    ],
                  ),
                  SubsectionModel(
                    title: '1.1.3',
                    videos: [
                      VideoModel(
                        title: 'Final Section Part 1',
                        status: VideoStatus.uncompleted,
                        category: 'Series',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          ChapterSection(
            title: '1.2',
            status: VideoStatus.uncompleted,
            videos: sectionVideos['1.2'] ?? [],
          ),
          ChapterSection(
            title: '1.3',
            status: VideoStatus.unwatched,
            videos: [],
          ),
          ChapterSection(
            title: '1.4',
            status: VideoStatus.unwatched,
            videos: [],
          ),
          ChapterSection(
            title: '1.5',
            status: VideoStatus.unwatched,
            videos: [],
          ),
        ],
      ),
      ChapterModel(
        title: 'Chapter 2',
        sections: [
          ChapterSection(
            title: '2.1',
            status: VideoStatus.unwatched,
            videos: [],
          ),
          ChapterSection(
            title: '2.2',
            status: VideoStatus.unwatched,
            videos: [],
          ),
          ChapterSection(
            title: '2.3',
            status: VideoStatus.unwatched,
            videos: [],
          ),
          ChapterSection(
            title: '2.4',
            status: VideoStatus.unwatched,
            videos: [],
          ),
          ChapterSection(
            title: '2.5',
            status: VideoStatus.unwatched,
            videos: [],
          ),
        ],
      ),
    ];
  }

  Map<String, List<VideoModel>> sectionVideos = {
    '1.1': [
      VideoModel(
        title: 'Introduction to Section 1.1',
        status: VideoStatus.completed,
        category: 'Basics',
        isSeries: false,
      ),
      VideoModel(
        title: 'Core Concepts of 1.1',
        status: VideoStatus.completed,
        category: 'Fundamentals',
        isSeries: true,
      ),
    ],
    '1.2': [
      VideoModel(
        title: 'Getting Started with 1.2',
        status: VideoStatus.uncompleted,
        category: 'Intermediate',
        isSeries: false,
      ),
      VideoModel(
        title: 'Getting Started with 1.2',
        status: VideoStatus.uncompleted,
        category: 'Intermediate',
        isSeries: false,
      ),
      VideoModel(
        title: 'Getting Started with 1.2',
        status: VideoStatus.uncompleted,
        category: 'Intermediate',
        isSeries: false,
      ),
      VideoModel(
        title: 'Getting Started with 1.2',
        status: VideoStatus.uncompleted,
        category: 'Intermediate',
        isSeries: false,
      ),
    ],
  };

  List<VideoModel> get currentSectionVideos {
    if (selectedSection == null) return [];

    final section = chapters[selectedSection!['chapterIndex']]
        .sections[selectedSection!['sectionIndex']];

    if (showingSubsections && selectedVideo != null) {
      return section
          .getVideosForSubsection(selectedVideo!['currentSubsection']);
    }

    return section.currentVideos;
  }

  void showNoVideosSnackbar() {
    if (!_hasShownSnackbar) {
      Get.snackbar(
        AppStrings.noVideos,
        AppStrings.noVideosAvailable,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.whiteColor,
        margin: EdgeInsets.all(8.w),
      );
      _hasShownSnackbar = true;
    }
  }

  void selectSection(int chapterIndex, int sectionIndex) async {
    isLoading = true;
    showingSubsections = false;
    selectedVideo = null;
    _hasShownSnackbar = false;

    if (selectedSection != null) {
      previousVideoCount = currentSectionVideos.length;
    }

    update();

    selectedSection = {
      'chapterIndex': chapterIndex,
      'sectionIndex': sectionIndex,
    };

    await Future.delayed(const Duration(milliseconds: 500));

    isLoading = false;
    update();
  }

  void selectVideo(Map<String, dynamic> video) {
    if (video['isSeries'] == true) {
      final section = chapters[selectedSection!['chapterIndex']]
          .sections[selectedSection!['sectionIndex']];

      final videoModel = section.videos.firstWhere(
        (v) => v.title == video['title'],
        orElse: () => VideoModel(
          title: '',
          status: VideoStatus.unwatched,
          category: '',
        ),
      );

      if (videoModel.subsections?.isNotEmpty ?? false) {
        selectedVideo = {
          'title': videoModel.title,
          'isSeries': true,
          'status': videoModel.status.name,
          'category': videoModel.category,
          'currentSubsection':
              videoModel.subsections![0].title, // Set initial subsection
        };
        showingSubsections = true;
        update();
      }
    }
  }

  List<String> getCurrentSubsections() {
    if (!showingSubsections || selectedVideo == null) return [];

    final section = chapters[selectedSection!['chapterIndex']]
        .sections[selectedSection!['sectionIndex']];

    return section.getSubsectionsForVideo(selectedVideo!['title']);
  }

  void selectSubsection(String subsection) {
    if (selectedVideo != null) {
      selectedVideo = {
        ...selectedVideo!,
        'currentSubsection': subsection,
      };
      update();
    }
  }

  bool isSubsectionSelected(String subsection) {
    return selectedVideo?['currentSubsection'] == subsection;
  }

  void goBackToVideos() {
    showingSubsections = false;
    selectedVideo = null;
    update();
  }

  int get shimmerCount {
    if (selectedSection == null) return 3;
    final sectionTitle =
        '${selectedSection!['chapterIndex'] + 1}.${selectedSection!['sectionIndex'] + 1}';
    return sectionVideos[sectionTitle]?.length ?? previousVideoCount;
  }

  bool isChapterMostlyCompleted(String sectionTitle) {
    final videos = sectionVideos[sectionTitle] ?? [];
    if (videos.isEmpty) return false;
    return videos.every((video) => video.status == VideoStatus.completed);
  }

  bool hasUncompletedVideos(String sectionTitle) {
    final videos = sectionVideos[sectionTitle] ?? [];
    if (videos.isEmpty) return false;
    return videos.any((video) => video.status == VideoStatus.uncompleted);
  }

  String getSectionStatus(int chapterIndex, int sectionIndex) {
    final sectionTitle = '${chapterIndex + 1}.${sectionIndex + 1}';

    if (isChapterMostlyCompleted(sectionTitle)) {
      return VideoStatus.completed.name;
    } else if (hasUncompletedVideos(sectionTitle)) {
      return VideoStatus.uncompleted.name;
    } else {
      return VideoStatus.unwatched.name;
    }
  }

  VideoStatus getSubsectionStatus(String subsectionTitle) {
    if (selectedSection == null || selectedVideo == null)
      return VideoStatus.unwatched;

    final section = chapters[selectedSection!['chapterIndex']]
        .sections[selectedSection!['sectionIndex']];

    final video = section.videos.firstWhere(
      (v) => v.title == selectedVideo!['title'] && v.isSeries,
      orElse: () => VideoModel(
        title: '',
        status: VideoStatus.unwatched,
        category: '',
      ),
    );

    final subsection = video.subsections?.firstWhere(
      (s) => s.title == subsectionTitle,
      orElse: () => SubsectionModel(title: '', videos: []),
    );

    if (subsection == null) return VideoStatus.unwatched;

    // Check if all videos in subsection are completed
    if (subsection.videos.every((v) => v.status == VideoStatus.completed)) {
      return VideoStatus.completed;
    }
    // Check if any video is uncompleted
    if (subsection.videos.any((v) => v.status == VideoStatus.uncompleted)) {
      return VideoStatus.uncompleted;
    }
    return VideoStatus.unwatched;
  }

  @override
  void onClose() {
    sidebarScrollController.dispose();
    super.onClose();
  }

  void scrollToBottom() {
    sidebarScrollController.animateTo(
      sidebarScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
