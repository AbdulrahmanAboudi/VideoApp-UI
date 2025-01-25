import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_app/core/constants/strings/app_strings.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChapterScreenController extends GetxController {
  Map<String, dynamic>? selectedSection;
  bool isLoading = false;
  int previousVideoCount = 0;
  Map<String, dynamic>? selectedVideo;
  bool showingSubsections = false;
  bool _hasShownSnackbar = false;
  final ScrollController sidebarScrollController = ScrollController();

  final List<Map<String, dynamic>> chapters = [
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

  final Map<String, List<String>> sectionSubsections = {
    '1.1': ['1.1.1', '1.1.2', '1.1.3'],
    '1.2': ['1.2.1', '1.2.2'],
  };

  final Map<String, List<Map<String, dynamic>>> sectionVideos = {
    '1.1': [
      {
        'title': 'Introduction to Section 1.1',
        'status': 'Completed',
        'category': 'Basics',
        'isSeries': false,
      },
      {
        'title': 'Core Concepts of 1.1',
        'status': 'Completed',
        'category': 'Fundamentals',
        'isSeries': true,
      },
    ],
    '1.2': [
      {
        'title': 'Getting Started with 1.2',
        'status': 'Uncompleted',
        'category': 'Intermediate',
        'isSeries': false,
      },
      {
        'title': 'Getting Started with 1.2',
        'status': 'Uncompleted',
        'category': 'Intermediate',
        'isSeries': false,
      },
      {
        'title': 'Getting Started with 1.2',
        'status': 'Uncompleted',
        'category': 'Intermediate',
        'isSeries': false,
      },
      {
        'title': 'Getting Started with 1.2',
        'status': 'Uncompleted',
        'category': 'Intermediate',
        'isSeries': false,
      },
    ],
  };

  final Map<String, List<String>> videoSubsections = {
    'Core Concepts of 1.1': ['1.1.1', '1.1.2', '1.1.3'],
  };

  final Map<String, List<Map<String, dynamic>>> subsectionVideos = {
    '1.1.1': [
      {
        'title': 'Part 1 of Series',
        'status': 'Completed',
        'category': 'Series',
        'isSeries': false,
      },
      {
        'title': 'Part 2 of Series',
        'status': 'Completed',
        'category': 'Series',
        'isSeries': false,
      },
    ],
    '1.1.2': [
      {
        'title': 'Advanced Concepts Part 1',
        'status': 'Unwatched',
        'category': 'Series',
        'isSeries': false,
      },
    ],
    '1.1.3': [
      {
        'title': 'Final Section Part 1',
        'status': 'Unwatched',
        'category': 'Series',
        'isSeries': false,
      },
    ],
  };

  List<Map<String, dynamic>> get currentSectionVideos {
    if (selectedSection == null) return [];

    final sectionTitle =
        '${selectedSection!['chapterIndex'] + 1}.${selectedSection!['sectionIndex'] + 1}';

    if (showingSubsections && selectedVideo != null) {
      final subsection = selectedVideo!['currentSubsection'];
      return subsectionVideos[subsection]?.cast<Map<String, dynamic>>() ?? [];
    }

    return sectionVideos[sectionTitle]?.cast<Map<String, dynamic>>() ?? [];
  }

  List<Map<String, dynamic>> getSectionItems(
      int chapterIndex, int sectionIndex) {
    final sectionTitle = '${chapterIndex + 1}.${sectionIndex + 1}';
    if (sectionSubsections.containsKey(sectionTitle) &&
        sectionVideos[sectionTitle]
                ?.any((video) => video['isSeries'] == true) ==
            true) {
      return sectionSubsections[sectionTitle]!
          .map((subsection) => {
                'title': subsection,
                'status': 'Unwatched',
                'isSubsection': true,
              })
          .toList();
    } else {
      return [
        chapters[chapterIndex]['sections'][sectionIndex] as Map<String, dynamic>
      ];
    }
  }

  void showNoVideosSnackbar() {
    if (!_hasShownSnackbar) {
      Get.snackbar(
        AppStrings.noVideos,
        AppStrings.noVideosAvailable,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
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
    if (video['isSeries'] == true &&
        videoSubsections.containsKey(video['title'])) {
      selectedVideo = video;
      showingSubsections = true;
      update();
    }
  }

  void selectSubsection(String subsection) {
    if (selectedVideo != null) {
      selectedVideo = {...selectedVideo!, 'currentSubsection': subsection};
      update();
    }
  }

  List<String> getCurrentSubsections() {
    if (!showingSubsections || selectedVideo == null) return [];
    return videoSubsections[selectedVideo!['title']] ?? [];
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

    // Check if ALL videos are completed
    return videos.every((video) => video['status'] == 'Completed');
  }

  bool hasUncompletedVideos(String sectionTitle) {
    final videos = sectionVideos[sectionTitle] ?? [];
    if (videos.isEmpty) return false;

    // Check if ANY video is uncompleted
    return videos.any((video) => video['status'] == 'Uncompleted');
  }

  String getSectionStatus(int chapterIndex, int sectionIndex) {
    final sectionTitle = '${chapterIndex + 1}.${sectionIndex + 1}';

    if (isChapterMostlyCompleted(sectionTitle)) {
      return 'Completed';
    } else if (hasUncompletedVideos(sectionTitle)) {
      return 'Uncompleted';
    } else {
      return 'Unwatched';
    }
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
