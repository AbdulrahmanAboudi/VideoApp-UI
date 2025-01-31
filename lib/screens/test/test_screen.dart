import 'package:flutter/material.dart';
import 'package:flutter_video_app/core/components/texts/main_text.dart';
import 'package:flutter_video_app/core/enums/text_font_type_enum.dart';
import 'package:flutter_video_app/core/components/texts/text_style/text_type.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextType textType = TextType(TextFontTypeEnum.inter);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen'),
      ),
      body: Center(
        child: MainText(
          text: 'Hello, Flutter!',
          textStyleConfig: textType.mediumSize,
          color: Colors.amber,
        ),
      ),
    );
  }
}
