part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}

final class ValidateLoginEmail extends AuthEvent {
  final String email;
  ValidateLoginEmail({
    required this.email,
  });
}

final class ValidateLoginPassword extends AuthEvent {
  final String password;
  ValidateLoginPassword({
    required this.password,
  });
}

final class SignupEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final File? imageFile;

  SignupEvent({
    required this.name,
    required this.email,
    required this.password,
    this.imageFile,
  });
}

final class ValidateSignupName extends AuthEvent {
  final String name;
  ValidateSignupName({
    required this.name,
  });
}

final class ValidateSignupEmail extends AuthEvent {
  final String email;
  ValidateSignupEmail({
    required this.email,
  });
}

final class ValidateSignupPassword extends AuthEvent {
  final String password;
  ValidateSignupPassword({
    required this.password,
  });
}

final class PickImageEvent extends AuthEvent {}

final class LogoutEvent extends AuthEvent {}

final class UsersStream extends AuthEvent {}
