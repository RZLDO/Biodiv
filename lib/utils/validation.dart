class Validator {
  static String? basicValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'this field cannot be empty';
    }
    return null; // input is valid
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null; // input is valid
  }
}
