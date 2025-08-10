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

  /// Convert a number to currency format with specified currency code
  ///
  /// Converts monetary amounts to their word representation including
  /// currency names and subunit handling (cents, pence, xu, etc.).
  ///
  /// Example:
  /// ```dart
  /// convertCurrency(123.45, 'USD'); // "one hundred twenty-three dollars and forty-five cents" (English)
  /// convertCurrency(123.45, 'EUR'); // "one hundred twenty-three euros and forty-five cents" (English)
  /// convertCurrency(123.45, 'VND'); // "một trăm hai mươi ba đồng và bốn mươi lăm xu" (Vietnamese)
  /// convertCurrency(123, 'JPY'); // "one hundred twenty-three yen" (English) - no subunits
  /// ```
  ///
  /// **Supported Currencies:**
  /// - USD (US Dollar), EUR (Euro), GBP (British Pound)
  /// - JPY (Japanese Yen), VND (Vietnamese Dong), CNY (Chinese Yuan)
  /// - KRW (Korean Won), THB (Thai Baht), SGD (Singapore Dollar)
  /// - AUD (Australian Dollar), CAD (Canadian Dollar), CHF (Swiss Franc)
  ///
  /// **Parameters:**
  /// - [amount] - The monetary amount (can include decimals)
  /// - [currencyCode] - ISO 4217 currency code (e.g., 'USD', 'EUR', 'VND')
  ///
  /// **Throws:**
  /// - [ArgumentError] if currency code is not supported
  /// - [ArgumentError] if amount is negative
  String convertCurrency(double amount, String currencyCode);
}
