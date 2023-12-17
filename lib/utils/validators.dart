class Validators {
  static bool isEmailAddressValid(String email) {
    final regex = RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    );
    return regex.hasMatch(email);
  }

  static bool isInputValid(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number is required';
    }

    if (phoneNumber.length < 11) {
      return 'Invalid Phone number';
    }

    return null;
  }

  static String? validEmailAddress(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Email is required';
    }

    //regex validates against nigerian phone numbers
    if (isEmailAddressValid(email.trim())) {
      return null;
    }
    return 'Invalid email address';
  }

  static String? nonEmptyField(String label, String? value) {
    return isInputValid(value) ? null : '$label is required';
  }
}
