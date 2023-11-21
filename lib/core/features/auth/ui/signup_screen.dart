import 'dart:async';
import 'dart:io';

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

  bool isEmailValid = true;
  String? errorEmail;

  bool isNameValid = true;
  String? errorName;

  bool isPasswordValid = true;
  String? errorPassword;

  Timer? _debounce;

  late AuthBloc authBloc;

  File? imageFile;

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
            if (state is SignupEmailValidState) {
              isEmailValid = state.isValid;
              errorEmail = state.errorText;
            }

            if (state is SignupPasswordValidState) {
              isPasswordValid = state.isValid;
              errorPassword = state.errorText;
            }

            if (state is SignupNameValidState) {
              isNameValid = state.isValid;
              errorName = state.errorText;
            }

            if (state is LoadingSignupState) {
              HelperFunctions.showLoadingDialog(
                context,
                Colors.transparent,
              );
            }

            if (state is SignupSuccessState) {
              Navigator.of(context)
                ..pop()
                ..pushAndRemoveUntil(
                  CupertinoPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (route) => false,
                );
            }

            if (state is SignupFailureState) {
              Navigator.pop(context);
              HelperFunctions.showSnackBar(
                state.message,
                context,
              );
            }

            if (state is ImagePickedState) {
              imageFile = state.imageFile;
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
                    Center(
                      child: ProfilePlaceholder(
                        imageFile: imageFile,
                        onTap: () {
                          authBloc.add(PickImageEvent());
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    AppTextField(
                      placeHolderText: 'Name',
                      controller: nameController,
                      focusNode: nameNode,
                      onChange: (value) {
                        if (_debounce?.isActive ?? false) {
                          _debounce?.cancel();
                        }
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          authBloc.add(ValidateSignupName(name: value));
                        });
                      },
                    ),
                    if (!isNameValid) ...[
                      Text(
                        errorName ?? '',
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
                      placeHolderText: 'Email',
                      controller: emailController,
                      focusNode: emailNode,
                      onChange: (value) {
                        if (_debounce?.isActive ?? false) {
                          _debounce?.cancel();
                        }
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          authBloc.add(ValidateSignupEmail(email: value));
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
                      controller: passwordController,
                      focusNode: passwordNode,
                      obscureText: obscureText,
                      onChange: (value) {
                        if (_debounce?.isActive ?? false) {
                          _debounce?.cancel();
                        }
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          authBloc.add(ValidateSignupPassword(password: value));
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
                      height: 24.h,
                    ),
                    Center(
                      child: AppPrimaryButton(
                        buttonText: 'Sign Up',
                        onTap: () {
                          authBloc.add(
                            SignupEvent(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              imageFile: imageFile,
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
            );
          },
        ),
      ),
    );
  }
}
