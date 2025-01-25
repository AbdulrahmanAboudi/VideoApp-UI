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
        return 'Aboreto'; 
      case TextFontTypeEnum.inter:
        return 'Inter';
      // ignore: unreachable_switch_default
      default:
        return 'Arial'; 
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
