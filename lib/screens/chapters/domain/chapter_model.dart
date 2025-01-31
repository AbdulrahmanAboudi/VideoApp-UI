import 'package:flutter_video_app/core/enums/video_status_enum.dart';
import 'package:flutter_video_app/screens/chapters/domain/video_model.dart';

class ChapterSection {
  final String title;
  final VideoStatus status;
  final List<VideoModel> videos;

  ChapterSection({
    required this.title,
    required this.status,
    required this.videos,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'status': status.name,
      'videos': videos.map((v) => v.toMap()).toList(),
    };
  }

  List<VideoModel> get currentVideos {
    return videos;
  }

  List<String> getSubsectionsForVideo(String videoTitle) {
    // First check direct videos in this section
    final video = videos.firstWhere(
      (v) => v.title == videoTitle && v.isSeries,
      orElse: () => VideoModel(
        title: '',
        status: VideoStatus.unwatched,
        category: '',
      ),
    );
    if (video.subsections?.isNotEmpty ?? false) {
      return video.subsections!.map((s) => s.title).toList();
    }

    // If not found, check in subsections
    for (var video in videos) {
      if (video.isSeries) {
        for (var subsection in video.subsections ?? []) {
          final nestedVideo = subsection.videos.firstWhere(
            (v) => v.title == videoTitle && v.isSeries,
            orElse: () => VideoModel(
              title: '',
              status: VideoStatus.unwatched,
              category: '',
            ),
          );
          if (nestedVideo.subsections?.isNotEmpty ?? false) {
            return nestedVideo.subsections!.map((s) => s.title).toList();
          }
        }
      }
    }
    return [];
  }

  List<VideoModel> getVideosForSubsection(String subsectionTitle) {
    // First check direct subsections
    for (var video in videos) {
      if (video.isSeries) {
        final subsection = video.subsections?.firstWhere(
          (s) => s.title == subsectionTitle,
          orElse: () => SubsectionModel(title: '', videos: []),
        );
        if (subsection != null && subsection.videos.isNotEmpty) {
          return subsection.videos;
        }

        // Check nested subsections
        for (var subsection in video.subsections ?? []) {
          for (var nestedVideo in subsection.videos) {
            if (nestedVideo.isSeries) {
              final nestedSubsection = nestedVideo.subsections?.firstWhere(
                (s) => s.title == subsectionTitle,
                orElse: () => SubsectionModel(title: '', videos: []),
              );
              if (nestedSubsection != null &&
                  nestedSubsection.videos.isNotEmpty) {
                return nestedSubsection.videos;
              }
            }
          }
        }
      }
    }
    return [];
  }
}

class ChapterModel {
  final String title;
  final List<ChapterSection> sections;

  ChapterModel({
    required this.title,
    required this.sections,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'sections': sections.map((s) => s.toMap()).toList(),
    };
  }
}
