import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gorintest/common/utils/validators.dart';
import 'package:gorintest/core/features/auth/repo/auth_repo.dart';
import 'package:gorintest/core/model/app_user.dart';
import 'package:gorintest/core/networking/api_response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final authRepo = AuthRepository();
  AppUser? appUser;
  final picker = ImagePicker();

  AuthBloc() : super(AuthInitial()) {
    on<ValidateLoginEmail>((event, emit) {
      bool isValid = Validators.validateEmailAddress(event.email);
      emit(LoginEmailValidState(
        errorText: isValid
            ? ''
            : event.email.isEmpty
                ? 'Email cannot be empty'
                : 'Please enter a valid email',
        isValid: isValid,
      ));
    });

    on<ValidateLoginPassword>((event, emit) {
      bool isValid = Validators.validatePassword(event.password);
      emit(LoginPasswordValidState(
        errorText: isValid ? '' : 'Password cannot be less than 6 characters',
        isValid: isValid,
      ));
    });

    on<ValidateSignupEmail>((event, emit) {
      bool isValid = Validators.validateEmailAddress(event.email);
      emit(SignupEmailValidState(
        errorText: isValid
            ? ''
            : event.email.isEmpty
                ? 'Email cannot be empty'
                : 'Please enter a valid email',
        isValid: isValid,
      ));
    });

    on<ValidateSignupName>((event, emit) {
      bool isValid = Validators.validateName(event.name);
      emit(SignupNameValidState(
        errorText: isValid
            ? ''
            : event.name.isEmpty
                ? 'Name cannot be empty'
                : 'Please enter a valid name',
        isValid: isValid,
      ));
    });

    on<ValidateSignupPassword>((event, emit) {
      bool isValid = Validators.validatePassword(event.password);
      emit(SignupPasswordValidState(
        errorText: isValid ? '' : 'Password cannot be less than 6 characters',
        isValid: isValid,
      ));
    });

    on<PickImageEvent>((event, emit) async {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      File? file;
      if (image != null) {
        file = File(image.path);
      }
      emit(ImagePickedState(imageFile: file));
    });

    on<LoginEvent>((event, emit) async {
      if (event.email.isEmpty ||
          !Validators.validateEmailAddress(event.email)) {
        emit(LoginEmailValidState(
          isValid: false,
          errorText: event.email.isEmpty
              ? 'Email cannot be empty'
              : 'Please enter a valid email',
        ));
      } else if (!Validators.validatePassword(event.password)) {
        emit(LoginPasswordValidState(
          isValid: false,
          errorText: event.password.isEmpty
              ? 'Password cannot be empty'
              : 'Password length cannot be less than 6 characters',
        ));
      } else {
        emit(LoadingLoginState());
        ApiResponse<AppUser?> response = await authRepo.signInThroughFirebase(
          event.email,
          event.password,
        );

        if (response.status == Status.success) {
          appUser = response.data;
          emit(LoginSuccessState(appUser: appUser));
        } else {
          emit(LoginFailureState(message: response.message!));
        }
      }
    });

    on<SignupEvent>((event, emit) async {
      if (!Validators.validateName(event.name)) {
        emit(SignupNameValidState(
          isValid: false,
          errorText: event.name.isEmpty
              ? 'Name cannot be empty'
              : 'Please enter a valid name',
        ));
      } else if (event.email.isEmpty ||
          !Validators.validateEmailAddress(event.email)) {
        emit(SignupEmailValidState(
          isValid: false,
          errorText: event.email.isEmpty
              ? 'Email cannot be empty'
              : 'Please enter a valid email',
        ));
      } else if (!Validators.validatePassword(event.password)) {
        emit(SignupPasswordValidState(
          isValid: false,
          errorText: event.password.isEmpty
              ? 'Password cannot be empty'
              : 'Password length cannot be less than 6 characters',
        ));
      } else {
        emit(LoadingSignupState());
        ApiResponse<AppUser?> response = await authRepo.signUpFirebase(
          email: event.email,
          name: event.name,
          password: event.password,
          imageFile: event.imageFile,
        );

        if (response.status == Status.success) {
          appUser = response.data;
          emit(SignupSuccessState(appUser: appUser));
        } else {
          emit(SignupFailureState(message: response.message!));
        }
      }
    });
  }
}
