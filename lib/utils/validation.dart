class Validation {
  static Validation? _instance;
  static Validation get instance => _instance ??= Validation._();
  Validation._();

  bool isEmail({required String email}) {
    // r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$
    // r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\.]+\.(com|pk)+"
    final RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
    if (email.isNotEmpty && emailRegex.hasMatch(email))
      return true;
    else
      return false;
  }

  bool isContacts({required String contact}) {
    /// The regular expression for validating contacts in the app.
    final RegExp contactRegex = RegExp(r'^(03|3)\d{9}$');
    if (contact.isNotEmpty && contactRegex.hasMatch(contact))
      return true;
    else
      return false;
  }

  bool isName({required String name}) {
    /// The regular expression for validating names in the app.
    final RegExp nameRegex = RegExp(r'^[a-z A-Z]+$');
    if (name.isNotEmpty && nameRegex.hasMatch(name))
      return true;
    else
      return false;
  }

  bool isZipCode({required String zipCode}) {
    /// The regular expression for validating zip codes in the app.
    final RegExp zipCodeRegex = RegExp(r'^\d{5}$');
    if (zipCode.isNotEmpty && zipCodeRegex.hasMatch(zipCode))
      return true;
    else
      return false;
  }

  bool isCreditCardNumber({required String creditCardNumber}) {
    /// The regular expression for validating credit card numbers in the app.
    final RegExp creditCardNumberRegex =
        RegExp(r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14})$');
    if (creditCardNumber.isNotEmpty &&
        creditCardNumberRegex.hasMatch(creditCardNumber))
      return true;
    else
      return false;
  }

  bool isCreditCardCVV({required String creditCardCVV}) {
    /// The regular expression for validating credit card CVV in the app.
    final RegExp creditCardCVVRegex = RegExp(r'^[0-9]{3}$');
    if (creditCardCVV.isNotEmpty && creditCardCVVRegex.hasMatch(creditCardCVV))
      return true;
    else
      return false;
  }

  bool isCreditCardExpiry({required String isCreditCardExpiry}) {
    /// The regular expression for validating credit card expiry in the app.
    final RegExp creditCardExpiryRegex =
        RegExp(r'(0[1-9]|10|11|12)/20[0-9]{2}$');

    if (isCreditCardExpiry.isNotEmpty &&
        creditCardExpiryRegex.hasMatch(isCreditCardExpiry))
      return true;
    else
      return false;
  }

  bool isOtpDigit({required String isOtpDigit}) {
    /// The regular expression for validating credit card expiry in the app.
    final RegExp otpDigitRegex = RegExp(r'^[0-9]{1}$');

    if (isOtpDigit.isNotEmpty && otpDigitRegex.hasMatch(isOtpDigit))
      return true;
    else
      return false;
  }

  bool isErp({required String erp}) {
    /// The regular expression for validating erps in the app.
    final RegExp erpRegex = RegExp(r'^[1-9]{1}\d{4}$');

    if (erp.isNotEmpty && erpRegex.hasMatch(erp))
      return true;
    else
      return false;
  }

  void clear() {
    _instance = null;
  }
}
