import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gorintest/core/features/auth/bloc/auth_bloc.dart';
import 'package:gorintest/core/features/auth/ui/login_screen.dart';
import 'package:gorintest/core/features/auth/ui/splash_screen.dart';
import 'package:gorintest/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
          ],
          child: MaterialApp(
            title: 'Gorin Test Sami',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: false,
            ),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
