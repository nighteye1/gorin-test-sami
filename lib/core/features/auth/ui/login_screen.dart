import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gorintest/common/constants/app_colors.dart';
import 'package:gorintest/common/constants/app_text_styles.dart';
import 'package:gorintest/core/features/auth/ui/local_components/app_primary_button.dart';
import 'package:gorintest/core/features/auth/ui/local_components/app_text_button.dart';
import 'package:gorintest/core/features/auth/ui/local_components/app_text_field.dart';
import 'package:gorintest/core/features/auth/ui/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AppTextStyles textStyles = AppTextStyles();

  final controller = TextEditingController();
  final focusNode = FocusNode();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 48.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.iconColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 72.h,
                ),
                Center(
                  child: Text(
                    'Login with email',
                    style:
                        textStyles.kRegularTextStyle.copyWith(fontSize: 16.sp),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                const AppTextField(
                  placeHolderText: 'email',
                ),
                SizedBox(
                  height: 16.h,
                ),
                AppTextField(
                  placeHolderText: 'password',
                  controller: controller,
                  focusNode: focusNode,
                  obscureText: obscureText,
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: obscureText
                        ? const Icon(
                            Icons.visibility,
                            color: AppColors.iconColor,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: AppColors.iconColor,
                          ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                const Center(
                  child: AppTextButton(
                    buttonText: 'Forgot Password ?',
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                const Center(
                  child: AppPrimaryButton(
                    buttonText: 'Login',
                  ),
                ),
                SizedBox(
                  height: 48.h,
                ),
                Center(
                  child: Text(
                    'Don\'t have an account',
                    style: textStyles.kRegularTextStyle.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Center(
                  child: AppTextButton(
                    buttonText: 'Sign Up',
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
