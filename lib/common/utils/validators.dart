class Validators {
  static bool validateName(String name) {
    RegExp nameExp = RegExp(
      r"^[\p{L} .'-]+$",
      caseSensitive: false,
      unicode: true,
      dotAll: true,
    );

    if (nameExp.hasMatch(name.trim())) {
      return true;
    }

    return false;
  }

  static bool validatePhoneNumber(String number) {
    RegExp phoneExp = RegExp(
      r'^((\+923|03)(([0-4]{1}[0-9]{1})|(55)|(64))[0-9]{7})$',
      caseSensitive: false,
    );

    if (phoneExp.hasMatch(number)) return true;

    return false;
  }

  static bool validateEmailAddress(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool validatePassword(String password) {
    if (password.length < 6) {
      return false;
    }
    return true;
  }
}
