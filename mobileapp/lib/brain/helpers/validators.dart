class InputValidator {
  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty || name.length < 3) {
      return 'This field must have at least 3 characters';
    }
    return null;
  }

  static String? passwordValidator(String? pass) {
    if(pass == null || pass.isEmpty) {
      return 'This field must not be empty';
    }
    return null;
  }

  static String? phoneNumberValidator(String? phone) {
    if(phone == null || phone.isEmpty) {
      return 'This field must not be empty';
    }
    return null;
  }
}