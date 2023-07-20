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

  static String? validateRadius(String? value) {
    if (value == null || value.isEmpty) {
      return 'Radius cannot be empty';
    }
    if (value.length < 5) {
      return 'Radius Must be have 5';
    }
    return null; // input is valid
  }
}
