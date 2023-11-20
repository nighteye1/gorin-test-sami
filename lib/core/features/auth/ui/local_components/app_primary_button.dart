import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gorintest/common/constants/app_colors.dart';
import 'package:gorintest/common/constants/app_text_styles.dart';

class AppPrimaryButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const AppPrimaryButton({
    super.key,
    this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12).w,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(1, 1),
            )
          ],
        ),
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
