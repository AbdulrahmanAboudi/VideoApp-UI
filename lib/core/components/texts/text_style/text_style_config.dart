import 'package:flutter/material.dart';
import 'package:flutter_video_app/core/enums/text_font_type_enum.dart';

class TextStyleConfig {
  final double size;
  final FontWeight weight;
  final TextFontTypeEnum fontType;

  TextStyleConfig({
    required this.size,
    required this.weight,
    required this.fontType,
  });

  String get fontFamily {
    switch (fontType) {
      case TextFontTypeEnum.aboreto:
      
        return 'Aboreto'; // Define your font family here
      case TextFontTypeEnum.inter:
        return 'Inter'; // Define your font family here
      default:
        return 'Arial'; // Default font if none specified
    }
  }

  FontWeight get fontWeight => weight;

  double get fontSize => size;

  TextStyle get textStyle {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      fontFamily: fontFamily,
    );
  }
}
