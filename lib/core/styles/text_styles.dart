import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static const String _fontFamily = 'Aboreto';

  static TextStyle h1 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  static TextStyle h2 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
  );

  static TextStyle h3 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle body = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle caption = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle smallCaption = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle xSmallCaption = TextStyle(
    fontSize: 8.sp,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  static TextStyle withDecoration(
    TextStyle base, {
    bool underline = false,
    Color? decorationColor,
    double? decorationThickness,
  }) {
    return base.copyWith(
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
    );
  }
}
