import 'package:flutter_video_app/core/enums/video_status_enum.dart';

class VideoModel {
  final String title;
  final VideoStatus status;
  final String category;
  final bool isSeries;
  final List<SubsectionModel>? subsections;
  String? currentSubsection;

  VideoModel({
    required this.title,
    required this.status,
    required this.category,
    this.isSeries = false,
    this.subsections,
    this.currentSubsection,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      title: map['title'] ?? '',
      status: map['status'] ?? VideoStatus.unwatched,
      category: map['category'] ?? '',
      isSeries: map['isSeries'] ?? false,
      subsections: map['subsections'] != null
          ? List<SubsectionModel>.from(
              map['subsections'].map((x) => SubsectionModel.fromMap(x)))
          : null,
      currentSubsection: map['currentSubsection'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'status': status.name,
      'category': category,
      'isSeries': isSeries,
      'subsections': subsections?.map((s) => s.toMap()).toList(),
      'currentSubsection': currentSubsection,
    };
  }

  VideoModel copyWith({
    String? title,
    VideoStatus? status,
    String? category,
    bool? isSeries,
    List<SubsectionModel>? subsections,
    String? currentSubsection,
  }) {
    return VideoModel(
      title: title ?? this.title,
      status: status ?? this.status,
      category: category ?? this.category,
      isSeries: isSeries ?? this.isSeries,
      subsections: subsections ?? this.subsections,
      currentSubsection: currentSubsection ?? this.currentSubsection,
    );
  }
}

class SubsectionModel {
  final String title;
  final List<VideoModel> videos;

  SubsectionModel({
    required this.title,
    required this.videos,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'videos': videos.map((v) => v.toMap()).toList(),
    };
  }

  factory SubsectionModel.fromMap(Map<String, dynamic> map) {
    return SubsectionModel(
      title: map['title'] ?? '',
      videos: List<VideoModel>.from(
          map['videos'].map((x) => VideoModel.fromMap(x))),
    );
  }
}
