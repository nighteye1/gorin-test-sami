import 'package:bloc/bloc.dart';
import 'package:gorintest/core/features/auth/repo/auth_repo.dart';
import 'package:gorintest/core/model/app_user.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final authRepo = AuthRepository();

  HomeBloc() : super(HomeInitial()) {
    on<GetUsersStream>((event, emit) {
      emit(UsersStreamState(appUsers: authRepo.getUsers()));
    });

    on<LogoutEvent>((event, emit) async {
      emit(LoadingLogoutState());
      await authRepo.signOutThroughFirebase();
      emit(LogoutSuccessState());
    });
  }
}
