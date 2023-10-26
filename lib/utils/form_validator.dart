import 'package:vistorapp/utils/validation.dart';

class FormValidator {
  static FormValidator? _instance;
  static FormValidator get instance => _instance ??= FormValidator._();
  FormValidator._();

  /// The error message for invalid email input.
  final String _invalidEmailError = 'Please enter a valid email address';

  /// The error message for empty email input.
  final String _emptyEmailInputError = 'Please enter an email';

  /// The error message for empty password input.
  final String _emptyPasswordInputError = 'Please enter a password';

  /// The error message for invalid confirm password input.
  final String _invalidConfirmPwError = "Passwords don't match";

  /// The error message for invalid current password input.
  final String _invalidCurrentPwError = 'Invalid current password!';

  /// The error message for invalid new password input.
  final String _invalidNewPwError = "Current and new password can't be same";

  /// The error message for invalid name input.
  final String _invalidNameError = 'Please enter a valid Name ';
  final String _invalidAnyTextForm = 'Please enter a valid ';

  /// A method containing validation logic for email input.
  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return _emptyEmailInputError;
    } else if (!Validation.instance.isEmail(email: email)) {
      return _invalidEmailError;
    }
    return null;
  }

  /// A method containing validation logic for password input.
  String? passwordValidator(String? password) {
    if (password!.isEmpty) return _emptyPasswordInputError;
    return null;
  }

  /// A method containing validation logic for confirm password input.
  String? confirmPasswordValidator(String? confirmPw, String inputPw) {
    if (confirmPw == inputPw) return null;
    return _invalidConfirmPwError;
  }

  /// A method containing validation logic for current password input.
  String? currentPasswordValidator(String? inputPw, String currentPw) {
    if (inputPw == currentPw) return null;
    return _invalidCurrentPwError;
  }

  /// A method containing validation logic for new password input.
  String? newPasswordValidator(String? newPw, String currentPw) {
    if (newPw!.isEmpty) {
      return _emptyPasswordInputError;
    } else if (newPw == currentPw) {
      return _invalidNewPwError;
    }
    return null;
  }

  /// A method containing validation logic for name input.
  String? nameValidator(String? name) {
    if (name != null && Validation.instance.isName(name: name)) return null;
    return _invalidNameError;
  }

  String? anyTextFormValidator(String? value, String nameOfTextField) {
    if (value != null) return null;
    return "$_invalidAnyTextForm $nameOfTextField";
  }

  void clear() {
    _instance = null;
  }
}
