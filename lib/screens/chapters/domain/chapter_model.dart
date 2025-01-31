import 'package:flutter_video_app/core/enums/video_status_enum.dart';
import 'package:flutter_video_app/screens/chapters/domain/video_model.dart';

class ChapterSection {
  final String title;
  final String status;
  final List<VideoModel> videos;

  ChapterSection({
    required this.title,
    required this.status,
    required this.videos,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'status': status,
      'videos': videos.map((v) => v.toMap()).toList(),
    };
  }

  List<VideoModel> get currentVideos {
    return videos;
  }

  List<String> getSubsectionsForVideo(String videoTitle) {
    final video = videos.firstWhere(
      (v) => v.title == videoTitle && v.isSeries,
      orElse: () => VideoModel(
        title: '',
        status: VideoStatus.unwatched,
        category: '',
      ),
    );
    return video.subsections?.map((s) => s.title).toList() ?? [];
  }

  List<VideoModel> getVideosForSubsection(String subsectionTitle) {
    for (var video in videos) {
      if (video.isSeries) {
        final subsection = video.subsections?.firstWhere(
          (s) => s.title == subsectionTitle,
          orElse: () => SubsectionModel(title: '', videos: []),
        );
        if (subsection != null) {
          return subsection.videos;
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
