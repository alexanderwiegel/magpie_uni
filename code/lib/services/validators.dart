class FirstNameValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the first name';
    }
    if (value.length < 2) {
      return 'The name must be at least 2 characters long';
    }
    return null;
  }
}

class LastNameValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the last name';
    }
    if (value.length < 2) {
      return 'The name must be at least 2 characters long';
    }
    return null;
  }
}

class EmailValidator {
  static String? validate(String? value) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                r"{0,253}[a-zA-Z0-9])?)*$")
            .hasMatch(value!);
    if (value.isEmpty) {
      return 'Please enter an email address';
    } else if (!emailValid) {
      if (value.contains(' ')) {
        return null;
      } else {
        return 'Please enter a valid email address';
      }
    }
    return null;
  }
}

class PasswordValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Your password must be at least 6 characters long';
    }
    return null;
  }
}
