import 'package:firebase_auth/firebase_auth.dart';

class AuthExceptionHandler {
  static String getErrorMessageForExcpetion(FirebaseAuthException e) {
    switch (e.code) {
      case "invalid-email":
        return 'Your email address appears to be malformed.';
      case "wrong-password":
        return 'Your email or password is wrong.';
      case "weak-password":
        return 'Your password should be at least 6 characters.';
      case 'email-already-in-use':
        return 'The email address is already in use by other account.';
      case 'user-not-found' || 'INVALID_LOGIN_CREDENTIALS':
        return 'No account found for this email.';
      case 'user-disabled':
        return "Invalid User, Please create your account or try to contact our support.";
      case 'operation-not-allowed':
        return "Anonymous auth hasn't been enabled for this project.";
      case 'requires-recent-login':
        return 'Please login again to update your password.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
