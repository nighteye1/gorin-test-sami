import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gorintest/common/constants/app_colors.dart';
import 'package:gorintest/common/constants/app_text_styles.dart';
import 'package:gorintest/core/features/auth/bloc/auth_bloc.dart';
import 'package:gorintest/core/features/auth/repo/auth_repo.dart';
import 'package:gorintest/core/features/auth/ui/login_screen.dart';
import 'package:gorintest/core/features/home/ui/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    User? user = AuthRepository().auth.currentUser;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 1), () {
        if (user != null) {
          authBloc.add(GetAppUser(uid: user.uid));
          Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: Center(
        child: Text(
          'Gorin Test Sami',
          style: AppTextStyles().kSemiBoldTextStyle.copyWith(
                color: AppColors.buttonTextColor,
                fontSize: 18.sp,
              ),
        ),
      ),
    );
  }
}
