import 'dart:ui';
import 'package:flutter_video_app/core/components/texts/text_style/text_style_config.dart';
import 'package:flutter_video_app/core/enums/text_font_type_enum.dart';

class TextType {
  final TextFontTypeEnum font;

  TextType(this.font);

  TextStyleConfig get smallSize => TextStyleConfig(
        size: 12.0,
        weight: FontWeight.normal,
        fontType: font,
      );

  TextStyleConfig get mediumSize => TextStyleConfig(
        size: 16.0,
        weight: FontWeight.normal,
        fontType: font, 
      );

  TextStyleConfig get boldMediumSize => TextStyleConfig(
        size: 16.0,
        weight: FontWeight.bold,
        fontType: font,
      );

  TextStyleConfig get largeSize => TextStyleConfig(
        size: 24.0,
        weight: FontWeight.normal,
        fontType: font, 
      );

  TextStyleConfig get headingSize => TextStyleConfig(
        size: 32.0,
        weight: FontWeight.bold,
        fontType: font, 
      );
}
