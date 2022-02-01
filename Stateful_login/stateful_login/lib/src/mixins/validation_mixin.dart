import 'dart:core';
class ValidationMixin {
  String? validateEmail(value) {
    if (!value!.contains('@')) {
      return "please enter a valid email";
    }
    return null;
  }

  String? validatePassword(value) {
    if (value!.length < 4) {
      return "Password must be at least 4 characters";
    }
    return null;
  }
}
