import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gorintest/common/constants/app_colors.dart';
import 'package:gorintest/common/constants/app_text_styles.dart';
import 'package:gorintest/core/features/auth/ui/local_components/app_primary_button.dart';
import 'package:gorintest/core/features/auth/ui/local_components/app_text_button.dart';
import 'package:gorintest/core/features/auth/ui/local_components/app_text_field.dart';
import 'package:gorintest/core/features/auth/ui/local_components/profile_placeholder.dart';
import 'package:gorintest/core/features/auth/ui/login_screen.dart';
import 'package:gorintest/core/features/home/ui/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AppTextStyles textStyles = AppTextStyles();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final nameNode = FocusNode();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();

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
                Center(
                  child: Text(
                    'Sign up with email',
                    style: textStyles.kRegularTextStyle.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                const Center(
                  child: ProfilePlaceholder(),
                ),
                SizedBox(
                  height: 12.h,
                ),
                AppTextField(
                  placeHolderText: 'Name',
                  controller: nameController,
                  focusNode: nameNode,
                ),
                SizedBox(
                  height: 16.h,
                ),
                AppTextField(
                  placeHolderText: 'Email',
                  controller: emailController,
                  focusNode: emailNode,
                ),
                SizedBox(
                  height: 16.h,
                ),
                AppTextField(
                  placeHolderText: 'Password',
                  controller: passwordController,
                  focusNode: passwordNode,
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
                  height: 24.h,
                ),
                Center(
                  child: AppPrimaryButton(
                    buttonText: 'Sign Up',
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 48.h,
                ),
                Center(
                  child: Text(
                    'Already have an account?',
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
                    buttonText: 'Login',
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(
                          builder: (context) => const LoginScreen(),
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
