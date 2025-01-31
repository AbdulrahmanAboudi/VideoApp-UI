import 'package:flutter/material.dart';

enum CustomMessage {
  noVideos('No videos available'),
  noResults('No results found'),
  error('An error occurred'),
  loading('Loading...'),
  selectSection('Select a section'),
  empty('');

  final String message;
  const CustomMessage(this.message);

  bool get isEmpty => this == CustomMessage.empty;
  bool get isError => this == CustomMessage.error;

  TextStyle getStyle() {
    return switch (this) {
      CustomMessage.error => const TextStyle(color: Colors.red),
      CustomMessage.loading => const TextStyle(color: Colors.blue),
      _ => const TextStyle(color: Colors.grey),
    };
  }
}
