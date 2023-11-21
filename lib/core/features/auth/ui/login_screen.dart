import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gorintest/common/constants/app_colors.dart';
import 'package:gorintest/common/constants/app_text_styles.dart';
import 'package:gorintest/common/utils/helper_functions.dart';
import 'package:gorintest/core/features/auth/bloc/auth_bloc.dart';
import 'package:gorintest/core/features/auth/ui/local_components/app_primary_button.dart';
import 'package:gorintest/core/features/auth/ui/local_components/app_text_button.dart';
import 'package:gorintest/core/features/auth/ui/local_components/app_text_field.dart';
import 'package:gorintest/core/features/auth/ui/signup_screen.dart';
import 'package:gorintest/core/features/home/ui/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AppTextStyles textStyles = AppTextStyles();

  final emailController = TextEditingController();
  final emailNode = FocusNode();

  final controller = TextEditingController();
  final focusNode = FocusNode();
  bool obscureText = true;

  late AuthBloc authBloc;

  Timer? _debounce;

  bool isEmailValid = true;
  String? errorEmail;

  bool isPasswordValid = true;
  String? errorPassword;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: BlocConsumer(
          bloc: authBloc,
          listener: (context, state) {
            if (state is LoginEmailValidState) {
              isEmailValid = state.isValid;
              errorEmail = state.errorText;
            }

            if (state is LoginPasswordValidState) {
              isPasswordValid = state.isValid;
              errorPassword = state.errorText;
            }

            if (state is LoadingLoginState) {
              HelperFunctions.showLoadingDialog(
                context,
                Colors.transparent,
              );
            }

            if (state is LoginFailureState) {
              Navigator.pop(context);
              HelperFunctions.showSnackBar(
                state.message,
                context,
              );
            }

            if (state is LoginSuccessState) {
              Navigator.of(context)
                ..pop()
                ..pushAndRemoveUntil(
                  CupertinoPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (route) => false,
                );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
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
                        style: textStyles.kRegularTextStyle
                            .copyWith(fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    AppTextField(
                      placeHolderText: 'Email',
                      controller: emailController,
                      focusNode: emailNode,
                      onChange: (value) {
                        if (_debounce?.isActive ?? false) {
                          _debounce?.cancel();
                        }
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          authBloc.add(ValidateLoginEmail(email: value));
                        });
                      },
                    ),
                    if (!isEmailValid) ...[
                      Text(
                        errorEmail ?? '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      )
                    ],
                    SizedBox(
                      height: 16.h,
                    ),
                    AppTextField(
                      placeHolderText: 'Password',
                      controller: controller,
                      focusNode: focusNode,
                      obscureText: obscureText,
                      onChange: (value) {
                        if (_debounce?.isActive ?? false) {
                          _debounce?.cancel();
                        }
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          authBloc.add(ValidateLoginPassword(password: value));
                        });
                      },
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
                    if (!isPasswordValid) ...[
                      Text(
                        errorPassword ?? '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      )
                    ],
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
                    Center(
                      child: AppPrimaryButton(
                        buttonText: 'Login',
                        onTap: () {
                          authBloc.add(LoginEvent(
                            email: emailController.text,
                            password: controller.text,
                          ));
                        },
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
            );
          },
        ),
      ),
    );
  }
}
