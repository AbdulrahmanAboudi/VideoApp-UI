import 'package:flutter/material.dart';
import 'package:flutter_video_app/core/components/texts/text_style/text_style_config.dart';

class MainText extends StatelessWidget {
  const MainText({
    super.key,
    required this.text,
    required this.textStyleConfig,
    this.color,
    this.maxLines,
    this.overflow,
    this.textAlign,
  });

  final String text;
  final TextStyleConfig textStyleConfig;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textStyleConfig.fontSize, 
        fontWeight: textStyleConfig.fontWeight,
        fontFamily: textStyleConfig.fontFamily, 
        color: color ?? Colors.green,
      ),
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
