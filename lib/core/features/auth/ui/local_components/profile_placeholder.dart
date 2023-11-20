import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gorintest/common/constants/app_colors.dart';

class ProfilePlaceholder extends StatelessWidget {
  final void Function()? onTap;
  const ProfilePlaceholder({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70.w,
        height: 70.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
        ),
        child: const Center(
          child: Icon(
            Icons.person,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
