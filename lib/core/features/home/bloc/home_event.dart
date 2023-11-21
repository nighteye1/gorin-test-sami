part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class GetUsersStream extends HomeEvent {}

final class LogoutEvent extends HomeEvent {}