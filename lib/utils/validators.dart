class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validateUsernameOrEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username or email';
    }

    final emailRegex = RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(value) && value.length < 3) {
      return 'Enter a valid email or username';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateField(String? value, String fieldName) {
    return (value == null || value.isEmpty) ? '$fieldName is required' : null;
  }

  static String? validateConfirmPassword(
      String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
