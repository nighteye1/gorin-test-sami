import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gorintest/common/constants/app_colors.dart';
import 'package:gorintest/common/constants/app_text_styles.dart';
import 'package:gorintest/core/features/auth/ui/local_components/app_text_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AppTextStyles styles = AppTextStyles();

  List<String> names = [
    'User',
    'User',
    'User',
    'User',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 48.h,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16).w,
              child: Text(
                'Users',
                style: styles.kMediumTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 24, left: 12).w,
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Expanded(
                          child: Text(
                            names[index],
                            style: styles.kRegularTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return Divider(
                    thickness: 1,
                    color: Colors.grey.shade400,
                    indent: 10.w,
                  );
                },
                itemCount: names.length,
              ),
            ),
            const Center(child: AppTextButton(buttonText: 'Logout')),
            SizedBox(
              height: 24.h,
            ),
          ],
        ),
      ),
    );
  }
}
