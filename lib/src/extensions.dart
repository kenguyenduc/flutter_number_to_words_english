import 'number_to_words.dart';

/// Extension on [num] to provide convenient number-to-words conversion
///
/// This extension adds methods directly to number types, allowing for
/// more intuitive syntax when converting numbers to words.
extension NumberToWordsExtension on num {
  /// Convert this number to words in English
  ///
  /// This is a convenience method that converts the number to English words.
  /// It's equivalent to calling `NumberToWords.convert('en', this)`.
  ///
  /// Example:
  /// ```dart
  /// print(123.toWords()); // "one hundred twenty-three"
  /// print((-45).toWords()); // "minus forty-five"
  /// print(12.34.toWords()); // "twelve point three four"
  /// ```
  String toWords() {
    return NumberToWords.convert('en', this);
  }

  /// Convert this number to words in the specified language
  ///
  /// [languageCode] - Language code ('en', 'vi', 'es')
  ///
  /// This method allows converting the number to words in any supported language.
  ///
  /// Example:
  /// ```dart
  /// print(123.toWords('en')); // "one hundred twenty-three"
  /// print(123.toWords('vi')); // "một trăm hai mười ba"
  /// print(123.toWords('es')); // "ciento veintitrés"
  /// ```
  ///
  /// Throws [ArgumentError] if the language is not supported.
  String toWordsInLanguage(String languageCode) {
    return NumberToWords.convert(languageCode, this);
  }

  /// Convert this number to words in Vietnamese
  ///
  /// This is a convenience method for Vietnamese conversion.
  /// It's equivalent to calling `NumberToWords.convert('vi', this)`.
  ///
  /// Example:
  /// ```dart
  /// print(123.toVietnamese()); // "một trăm hai mười ba"
  /// print((-45).toVietnamese()); // "âm bốn mười năm"
  /// ```
  String toVietnamese() {
    return NumberToWords.convert('vi', this);
  }

  /// Convert this number to words in Spanish
  ///
  /// This is a convenience method for Spanish conversion.
  /// It's equivalent to calling `NumberToWords.convert('es', this)`.
  ///
  /// Example:
  /// ```dart
  /// print(123.toSpanish()); // "ciento veintitrés"
  /// print((-45).toSpanish()); // "menos cuarenta y cinco"
  /// ```
  String toSpanish() {
    return NumberToWords.convert('es', this);
  }

  /// Convert this number to words in English (explicit)
  ///
  /// This is an explicit method for English conversion, useful when you want
  /// to be explicit about the language or when method names conflict.
  ///
  /// Example:
  /// ```dart
  /// print(123.toEnglish()); // "one hundred twenty-three"
  /// ```
  String toEnglish() {
    return NumberToWords.convert('en', this);
  }

  /// Convert this number to words in French
  ///
  /// Example:
  /// ```dart
  /// print(123.toFrench()); // "cent vingt-trois"
  /// ```
  String toFrench() {
    return NumberToWords.convert('fr', this);
  }

  /// Convert this number to words in German
  ///
  /// Example:
  /// ```dart
  /// print(123.toGerman()); // "einhundertdreiundzwanzig"
  /// ```
  String toGerman() {
    return NumberToWords.convert('de', this);
  }

  /// Convert this number to words in Italian
  ///
  /// Example:
  /// ```dart
  /// print(123.toItalian()); // "centoventitre"
  /// ```
  String toItalian() {
    return NumberToWords.convert('it', this);
  }

  /// Convert this number to words in Portuguese
  ///
  /// Example:
  /// ```dart
  /// print(123.toPortuguese()); // "cento e vinte e três"
  /// ```
  String toPortuguese() {
    return NumberToWords.convert('pt', this);
  }

  /// Convert this number to words in Russian
  ///
  /// Example:
  /// ```dart
  /// print(123.toRussian()); // "сто двадцать три"
  /// ```
  String toRussian() {
    return NumberToWords.convert('ru', this);
  }

  /// Convert this number to words in Chinese
  ///
  /// Example:
  /// ```dart
  /// print(123.toChinese()); // "一百二十三"
  /// ```
  String toChinese() {
    return NumberToWords.convert('zh', this);
  }

  /// Convert this number to words in Japanese
  ///
  /// Example:
  /// ```dart
  /// print(123.toJapanese()); // "ひゃくにじゅうさん"
  /// ```
  String toJapanese() {
    return NumberToWords.convert('ja', this);
  }

  /// Convert this number to words in Dutch
  ///
  /// Example:
  /// ```dart
  /// print(123.toDutch()); // "honderddrieëntwintig"
  /// ```
  String toDutch() {
    return NumberToWords.convert('nl', this);
  }

  /// Convert this number to words in Arabic
  ///
  /// Example:
  /// ```dart
  /// print(123.toArabic()); // "مائة ثلاثة وعشرون"
  /// ```
  String toArabic() {
    return NumberToWords.convert('ar', this);
  }
}

/// Extension on [int] to provide integer-specific conversion methods
///
/// This extension provides additional methods specifically for integers,
/// including cardinal and ordinal number conversion.
extension IntegerToWordsExtension on int {
  /// Convert this integer to cardinal words in English
  ///
  /// Cardinal numbers are regular counting numbers (one, two, three, etc.).
  /// This is the same as [toWords] but explicitly for cardinal numbers.
  ///
  /// Example:
  /// ```dart
  /// print(1.toCardinal()); // "one"
  /// print(21.toCardinal()); // "twenty-one"
  /// ```
  String toCardinal([String languageCode = 'en']) {
    return NumberToWords.convert(languageCode, this);
  }

  /// Check if this number can be converted to words
  ///
  /// Returns `true` if the number is within the supported range for conversion.
  /// This is useful for validation before attempting conversion.
  ///
  /// Example:
  /// ```dart
  /// print(123.canConvertToWords()); // true
  /// print(999999999999999.canConvertToWords()); // true (within range)
  /// ```
  bool canConvertToWords() {
    // Check if the number is within supported range
    return abs() <= 999999999999999; // Up to quadrillion range
  }

  /// Get the word length of this number when converted to English words
  ///
  /// Returns the number of characters in the English word representation.
  /// This excludes spaces and hyphens.
  ///
  /// Example:
  /// ```dart
  /// print(123.wordLength()); // Length of "one hundred twenty-three" without spaces/hyphens
  /// ```
  int wordLength([String languageCode = 'en']) {
    String words = NumberToWords.convert(languageCode, this);
    return words.replaceAll(RegExp(r'[\s\-]'), '').length;
  }

  /// Get the number of words when this number is converted to words
  ///
  /// Returns the count of individual words in the conversion.
  ///
  /// Example:
  /// ```dart
  /// print(123.wordCount()); // 4 (one, hundred, twenty, three)
  /// print(21.wordCount()); // 1 (twenty-one is hyphenated, counts as one word)
  /// ```
  int wordCount([String languageCode = 'en']) {
    String words = NumberToWords.convert(languageCode, this);
    return words.split(RegExp(r'\s+')).length;
  }
}

/// Extension on [double] to provide double-specific conversion methods
extension DoubleToWordsExtension on double {
  /// Convert this double to words with decimal part
  ///
  /// This method explicitly handles the decimal conversion, useful when you want
  /// to be explicit about decimal handling.
  ///
  /// Example:
  /// ```dart
  /// print(12.34.toWordsWithDecimal()); // "twelve point three four"
  /// print((-12.34).toWordsWithDecimal()); // "minus twelve point three four"
  /// ```
  String toWordsWithDecimal([String languageCode = 'en']) {
    return NumberToWords.convert(languageCode, this);
  }

  /// Convert only the integer part of this double to words
  ///
  /// This method ignores the decimal part and only converts the integer portion.
  ///
  /// Example:
  /// ```dart
  /// print(12.34.integerPartToWords()); // "twelve"
  /// print((-12.34).integerPartToWords()); // "minus twelve"
  /// ```
  String integerPartToWords([String languageCode = 'en']) {
    return NumberToWords.convert(languageCode, truncate());
  }

  /// Get the decimal part of this double as words
  ///
  /// This method only converts the decimal digits, excluding the integer part.
  ///
  /// Example:
  /// ```dart
  /// print(12.34.decimalPartToWords()); // "three four"
  /// print(12.05.decimalPartToWords()); // "zero five"
  /// ```
  String decimalPartToWords([String languageCode = 'en']) {
    String numberStr = toString();
    List<String> parts = numberStr.split('.');
    if (parts.length < 2) return '';

    String decimalPart = parts[1];
    // Check if decimal part is all zeros (like 12.0)
    if (decimalPart.replaceAll('0', '').isEmpty) return '';

    // Convert each digit individually
    final language = NumberToWords.getLanguage(languageCode);
    List<String> digits = [];
    for (int i = 0; i < decimalPart.length; i++) {
      int digit = int.parse(decimalPart[i]);
      String digitWord = language.convertIntegerPart(digit);
      digits.add(digitWord);
    }
    return digits.join(' ');
  }
}

/// Extension on [String] to provide string-based number conversion
///
/// This extension allows converting number strings directly to words,
/// which is useful for handling very large numbers or precise decimal values.
extension StringNumberToWordsExtension on String {
  /// Convert this string (representing a number) to words
  ///
  /// [languageCode] - Language code ('en', 'vi', 'es')
  ///
  /// This method is useful for converting number strings that might be too large
  /// for standard number types or when you need precise decimal handling.
  ///
  /// Example:
  /// ```dart
  /// print("123.456".toWordsFromString()); // "one hundred twenty-three point four five six"
  /// print("999999999999999".toWordsFromString()); // converts very large numbers
  /// ```
  ///
  /// Throws [ArgumentError] if the string is not a valid number or
  /// if the language is not supported.
  String toWordsFromString([String languageCode = 'en']) {
    return NumberToWords.convertDecimal(languageCode, this);
  }

  /// Check if this string represents a valid number for conversion
  ///
  /// Returns `true` if the string can be converted to words, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// print("123".isValidNumberString()); // true
  /// print("12.34".isValidNumberString()); // true
  /// print("-123.45".isValidNumberString()); // true
  /// print("abc".isValidNumberString()); // false
  /// ```
  bool isValidNumberString() {
    return RegExp(r'^-?\d+(\.\d+)?$').hasMatch(this);
  }

  /// Convert this string to words in multiple languages
  ///
  /// [languageCodes] - List of language codes to convert to
  ///
  /// Returns a map where keys are language codes and values are the
  /// word representations in those languages.
  ///
  /// Example:
  /// ```dart
  /// Map<String, String> results = "123".toWordsInMultipleLanguages(['en', 'vi', 'es']);
  /// // {
  /// //   'en': 'one hundred twenty-three',
  /// //   'vi': 'một trăm hai mười ba',
  /// //   'es': 'ciento veintitrés'
  /// // }
  /// ```
  Map<String, String> toWordsInMultipleLanguages(List<String> languageCodes) {
    Map<String, String> results = {};
    for (String code in languageCodes) {
      try {
        results[code] = NumberToWords.convertDecimal(code, this);
      } catch (e) {
        results[code] = 'Error: ${e.toString()}';
      }
    }
    return results;
  }
}
