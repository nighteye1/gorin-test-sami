part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingLoginState extends AuthState {}

final class LoginSuccessState extends AuthState {
  final User? user;
  final AppUser? appUser;
  LoginSuccessState({
    this.appUser,
    this.user,
  });
}

final class LoginFailureState extends AuthState {
  final String message;
  LoginFailureState({required this.message});
}

final class LoginEmailValidState extends AuthState {
  final String? errorText;
  final bool isValid;
  LoginEmailValidState({
    required this.errorText,
    required this.isValid,
  });
}

final class LoginPasswordValidState extends AuthState {
  final String? errorText;
  final bool isValid;
  LoginPasswordValidState({
    required this.errorText,
    required this.isValid,
  });
}

final class LoadingSignupState extends AuthState {}

final class SignupSuccessState extends AuthState {
  final User? user;
  final AppUser? appUser;
  SignupSuccessState({
    this.appUser,
    this.user,
  });
}

final class SignupNameValidState extends AuthState {
  final String? errorText;
  final bool isValid;
  SignupNameValidState({
    required this.errorText,
    required this.isValid,
  });
}

final class SignupEmailValidState extends AuthState {
  final String? errorText;
  final bool isValid;
  SignupEmailValidState({
    required this.errorText,
    required this.isValid,
  });
}

final class SignupPasswordValidState extends AuthState {
  final String? errorText;
  final bool isValid;
  SignupPasswordValidState({
    required this.errorText,
    required this.isValid,
  });
}

final class SignupFailureState extends AuthState {
  final String message;
  SignupFailureState({required this.message});
}

final class ImagePickedState extends AuthState {
  final File? imageFile;
  ImagePickedState({
    this.imageFile,
  });
}

final class GetUserSuccess extends AuthState {
  final AppUser appUser;
  GetUserSuccess({
    required this.appUser,
  });
}
