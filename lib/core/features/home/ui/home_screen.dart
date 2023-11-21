import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gorintest/common/constants/app_colors.dart';
import 'package:gorintest/common/constants/app_text_styles.dart';
import 'package:gorintest/common/utils/helper_functions.dart';
import 'package:gorintest/core/features/auth/bloc/auth_bloc.dart';
import 'package:gorintest/core/features/auth/ui/local_components/app_primary_button.dart';
import 'package:gorintest/core/features/auth/ui/login_screen.dart';
import 'package:gorintest/core/features/home/bloc/home_bloc.dart';
import 'package:gorintest/core/model/app_user.dart';

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

  late HomeBloc homeBloc;

  Stream<List<AppUser>>? appUsers;

  @override
  void initState() {
    homeBloc = HomeBloc();
    homeBloc.add(GetUsersStream());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: BlocConsumer(
          bloc: homeBloc,
          listener: (context, state) {
            if (state is UsersStreamState) {
              appUsers = state.appUsers;
            }

            if (state is LoadingLogoutState) {
              HelperFunctions.showLoadingDialog(
                context,
                Colors.transparent,
              );
            }

            if (state is LogoutSuccessState) {
              BlocProvider.of<AuthBloc>(context).appUser = null;
              Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 48.h,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16)
                          .w,
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
                  child: appUsers == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : StreamBuilder(
                          stream: appUsers,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  snapshot.error.toString(),
                                  style: styles.kRegularTextStyle,
                                ),
                              );
                            }

                            if (snapshot.hasData &&
                                (snapshot.data?.isNotEmpty ?? false)) {
                              return ListView.separated(
                                itemBuilder: (ctx, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      right: 24,
                                      left: 12,
                                    ).w,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40.w,
                                          height: 40.w,
                                          decoration: const BoxDecoration(
                                            color: AppColors.primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child:
                                              snapshot.data![index].imageUrl !=
                                                      null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        100,
                                                      ),
                                                      child: Image.network(
                                                        snapshot.data![index]
                                                            .imageUrl!,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : const Center(
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
                                            snapshot.data![index].name,
                                            style: styles.kRegularTextStyle
                                                .copyWith(
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
                                itemCount: snapshot.data?.length ?? 0,
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                ),
                Center(
                  child: AppPrimaryButton(
                    buttonText: 'Logout',
                    onTap: () {
                      homeBloc.add(LogoutEvent());
                    },
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
