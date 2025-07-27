/// Abstract base class for number to words conversion by language
abstract class NumberToWordsLanguage {
  /// Convert a number to words in the specific language
  String convert(num number);

  /// Convert a decimal number string to words
  String convertDecimal(String numberStr);

  /// Language code identifier (e.g., 'en', 'vi', 'es')
  String get languageCode;

  /// Human-readable language name
  String get languageName;

  /// Convert the integer part of a number to words
  String convertIntegerPart(int number);

  /// Convert a number less than one thousand to words
  String convertLessThanOneThousand(int number);

  /// Validate if the input string is a valid number
  bool isValidNumber(String numberStr) {
    return RegExp(r'^-?\d+(\.\d+)?$').hasMatch(numberStr);
  }

  /// Get the word for "minus" in this language
  String get minusWord;

  /// Get the word for "point" (decimal separator) in this language
  String get pointWord;

  /// Convert a number to ordinal words (1st, 2nd, 3rd, etc.)
  ///
  /// Example:
  /// ```dart
  /// convertOrdinal(1); // "first" (English), "thứ nhất" (Vietnamese)
  /// convertOrdinal(2); // "second" (English), "thứ hai" (Vietnamese)
  /// convertOrdinal(21); // "twenty-first" (English), "thứ hai mười một" (Vietnamese)
  /// ```
  String convertOrdinal(int number);
}
