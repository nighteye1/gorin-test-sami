part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LoadingLogoutState extends HomeState {}

final class UsersStreamState extends HomeState {
  final Stream<List<AppUser>> appUsers;
  UsersStreamState({
    required this.appUsers,
  });
}

final class LogoutSuccessState extends HomeState {}
