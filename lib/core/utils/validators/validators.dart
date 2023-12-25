/// A utility class for validating common user inputs like email, password, and phone number.
class AppValidator {
  /// Validates an email address.
  ///
  /// [value]: The email string to be validated.
  /// Returns a String error message if the email is invalid, otherwise returns null.
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!value.contains('@')) {
      return 'Email is invalid';
    }

    // Regular Expression for email validation
    final emailRegExp =
        RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Provided email is invalid';
    }
    return null;
  }

  /// Validates a password.
  ///
  /// [value]: The password string to be validated.
  /// Returns a String error message if the password is invalid, otherwise returns null.
  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password cannot be empty';
    }

    // Check for at least one numeric value
    final numericRegExp = RegExp(r'^(?=.*?[0-9]).{8,}$');
    if (!numericRegExp.hasMatch(value)) {
      return 'Password must contain at least one numeric value';
    }

    // Check for at least one uppercase letter
    final upperCaseRegExp = RegExp(r'^(?=.*?[A-Z]).{8,}$');
    if (!upperCaseRegExp.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!value.contains(RegExp(r'^(?=.*?[a-z]).{8,}$'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one special character
    if (!value.contains(RegExp(r'^(?=.*?[#?!@$%^&*-]).{8,}$'))) {
      return 'Password must contain at least one special character';
    }

    // Check for minimum password length
    if (value.length < 8) {
      return 'Password must be of length 8';
    }

    return null;
  }

  /// Validates a phone number.
  ///
  /// [value]: The phone number string to be validated.
  /// Returns a String error message if the phone number is invalid, otherwise returns null.
  static String? validatePhoneNumber(String? value) {
    // Check phoneNumber
    if (value!.isEmpty) {
      return 'Phone Number cannot be empty';
    }

    // Regular expression for phone number validation (Australian Number)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  /// Validates a username.
  ///
  /// [value]: The username string to be validated.
  /// Returns a String error message if the username is invalid, otherwise returns null.
  static String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return 'Username cannot be empty';
    }

    // Check for minimum and maximum length for username
    if (value.length < 3 || value.length > 20) {
      return 'Username must be between 3 and 20 characters';
    }

    // Check for alphanumeric characters and underscores
    final usernameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegExp.hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }

    return null;
  }

  /// Validates a URL.
  ///
  /// [value]: The URL string to be validated.
  /// Returns a String error message if the URL is invalid, otherwise returns null.
  static String? validateURL(String? value) {
    if (value!.isEmpty) {
      return 'URL cannot be empty';
    }

    // Regular Expression for URL validation
    final urlRegExp = RegExp(
        r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$');

    if (!urlRegExp.hasMatch(value)) {
      return 'Invalid URL';
    }

    return null;
  }
}
