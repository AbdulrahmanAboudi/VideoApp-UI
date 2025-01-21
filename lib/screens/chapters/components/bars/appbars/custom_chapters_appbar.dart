import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_app/core/constants/assets/app_images.dart';
import 'package:flutter_video_app/core/constants/strings/app_strings.dart';
import 'package:flutter_video_app/screens/chapters/components/buttons/header_icon_buttons.dart';

PreferredSize customChaptersAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(72.h),
    child: Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Container(
        width: double.infinity,
        height: 72.h,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black.withOpacity(0.1),
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w),
          child: Row(
            children: [
              _buildLogoWithTitle(),
              const Spacer(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildLogoWithTitle() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        AppImages.appbarImage,
        width: 32.w,
        height: 32.h,
      ),
      SizedBox(height: 4.h), 
      Text(
        AppStrings.videosTitle,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

Widget _buildActionButtons() {
  return Row(
    children: [
      IconButtonWithSize(
        image: AppImages.searchIcon,
        onPressed: () {},
      ),
      SizedBox(width: 8.w),
      IconButtonWithSize(
        image: AppImages.notificationsIcon,
        onPressed: () {},
      ),
      SizedBox(width: 8.w),
      IconButtonWithSize(
        image: AppImages.profileIcon,
        onPressed: () {},
      ),
    ],
  );
}
