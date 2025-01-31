import 'package:flutter/material.dart';
import 'package:flutter_video_app/core/constants/colors/app_colors.dart';

enum VideoStatus {
  completed,
  uncompleted,
  unwatched;

  const VideoStatus();

  String get name {
    switch (this) {
      case VideoStatus.completed:
        return 'Completed';
      case VideoStatus.uncompleted:
        return 'Uncompleted';
      case VideoStatus.unwatched:
        return 'Unwatched';
    }
  }

  Color get color {
    switch (this) {
      case VideoStatus.completed:
        return AppColors.greenColor;
      case VideoStatus.uncompleted:
        return AppColors.orangeColor;
      case VideoStatus.unwatched:
        return AppColors.greyColor;
    }
  }

  bool get isCompleted => this == VideoStatus.completed;
  bool get isUncompleted => this == VideoStatus.uncompleted;
  bool get isUnwatched => this == VideoStatus.unwatched;
}
