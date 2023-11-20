import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gorintest/common/constants/app_colors.dart';
import 'package:gorintest/common/constants/app_text_styles.dart';

class AppTextButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const AppTextButton({
    super.key,
    this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          buttonText,
          style: AppTextStyles().kMediumTextStyle.copyWith(
                fontSize: 14.sp,
                color: AppColors.buttonTextColor,
              ),
        ),
      ),
    );
  }
}
