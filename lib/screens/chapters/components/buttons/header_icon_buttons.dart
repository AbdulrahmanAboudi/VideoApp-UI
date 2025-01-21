import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconButtonWithSize extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;

  const IconButtonWithSize({
    super.key,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(
        image,
        width: 24.w,
        height: 24.h,
      ),
    );
  }
}
