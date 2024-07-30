class InputValidator {
  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty || name.length < 3) {
      return 'This field must have at least 3 characters';
    }
    return null;
  }

  static String? numberValidator(String? number) {
    if (number == null || number.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? passwordValidator(String? pass) {
    if(pass == null || pass.isEmpty) {
      return 'This field must not be empty';
    }
    return null;
  }

  static String? confirmPasswordValidator(String? pass1, String? pass2) {
    if(pass2 == null || pass2.isEmpty) {
      return 'This field must not be empty';
    }
    else if(pass1?.compareTo(pass2) != 0) {
      return 'Password and Confirm mut be equal';
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