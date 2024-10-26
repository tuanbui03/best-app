class TValidator {
  static String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'UserName is required';
    }
    return null;
  }
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Regular expression for email validation

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    String notification = '';
    if (value == null || value.isEmpty){
      return 'Password is required.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      notification += 'Password must be at least 6 characters long.\n';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))){
      notification += 'Password must contain at least one uppercase letter.\n';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))){
      notification += 'Password must contain at least one number.\n';
    }

    // Check for  special characters
    if(!value.contains(RegExp(r'[!@#$%^&*(),.?:{}|<>]'))){
      notification += 'Password must contain at least one special character.';
    }

    return (notification.isEmpty)?null:notification;
  }

  static String? validatePhoneNumber(String? value) {
    if(value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Regular expression for number validation (assuming a 10-digit VN phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).';
    }
    return null;
  }
}