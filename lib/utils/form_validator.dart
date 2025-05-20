class FormValidator {
  FormValidator._();

  static String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cannot be empty'; // TODO: Localize this string
    }
    return null;
  }
}
