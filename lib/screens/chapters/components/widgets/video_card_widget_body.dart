import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_app/core/constants/assets/app_images.dart';
import 'package:flutter_video_app/core/constants/strings/app_strings.dart';

Widget customVideoCardWidgetBody(String title, String status, String category) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          offset: const Offset(-2, 2),
          blurRadius: 4,
        ),
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          offset: const Offset(2, 2),
          blurRadius: 4,
        ),
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          offset: const Offset(0, 2),
          blurRadius: 4,
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Aboreto',
            ),
            overflow: TextOverflow.visible,
            maxLines: 2,
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    _buildStatusAndCategoryBlock(
                      Icons.check_circle,
                      status,
                      status == 'Completed'
                          ? Colors.green
                          : status == 'Uncompleted'
                              ? Colors.orange
                              : Colors.grey,
                      Icons.category,
                      category,
                      Colors.grey,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  spacing: 40.w,
                  children: List.generate(
                    2,
                    (index) {
                      List<Map<String, dynamic>> buttonDetails = [
                        {
                          'icon': AppImages.shareIcon,
                          'text': AppStrings.shareButton
                        },
                        {
                          'icon': AppImages.saveIcon,
                          'text': AppStrings.saveButton
                        }
                      ];
                      var button = buttonDetails[index];
                      return _buildTypeOfButton(button['icon'], button['text']);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStatusAndCategoryBlock(
  IconData statusIcon,
  String statusText,
  Color statusColor,
  IconData categoryIcon,
  String categoryText,
  Color categoryColor,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 5.h,
    children: [
      Row(
        spacing: 6.w,
        children: [
          Icon(
            statusIcon,
            color: statusColor,
            size: 16.sp,
          ),
          Text(
            statusText,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w400,
              fontSize: 10.sp,
            ),
          )
        ],
      ),
      Row(
        spacing: 6.w,
        children: [
          Icon(
            categoryIcon,
            color: categoryColor,
            size: 16.sp,
          ),
          Text(
            categoryText,
            style: TextStyle(
              color: categoryColor,
              fontWeight: FontWeight.w400,
              fontSize: 10.sp,
            ),
          )
        ],
      )
    ],
  );
}

Widget _buildTypeOfButton(String icon, String buttonText) {
  return Column(
    children: [
      Image.asset(
        icon,
        width: 15.w,
        height: 30.h,
      ),
      Text(
        buttonText,
        style: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontSize: 8.sp,
          fontWeight: FontWeight.w400,
        ),
      )
    ],
  );
}
