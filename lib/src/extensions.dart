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

  /// Convert this number to ordinal words in the default language (English)
  ///
  /// Converts the number to its ordinal form (1st, 2nd, 3rd, etc.) in English.
  /// Only works with positive integers.
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinal()); // "first"
  /// print(2.toOrdinal()); // "second"
  /// print(21.toOrdinal()); // "twenty-first"
  /// print(23.toOrdinal()); // "twenty-third"
  /// ```
  ///
  /// **Throws:**
  /// - [ArgumentError] if the number is not a positive integer
  String toOrdinal() {
    if (this != this.toInt() || this <= 0) {
      throw ArgumentError('Ordinal conversion requires positive integers');
    }
    return NumberToWords.convertOrdinal('en', this.toInt());
  }

  /// Convert this number to ordinal words in a specific language
  ///
  /// Converts the number to its ordinal form in the specified language.
  /// Only works with positive integers.
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinalInLanguage('en')); // "first"
  /// print(1.toOrdinalInLanguage('vi')); // "thứ nhất"
  /// print(1.toOrdinalInLanguage('fr')); // "premier"
  /// print(1.toOrdinalInLanguage('zh')); // "第一"
  /// ```
  ///
  /// **Parameters:**
  /// - [languageCode] - Language code for conversion
  ///
  /// **Throws:**
  /// - [ArgumentError] if the language is not supported
  /// - [ArgumentError] if the number is not a positive integer
  String toOrdinalInLanguage(String languageCode) {
    if (this != this.toInt() || this <= 0) {
      throw ArgumentError('Ordinal conversion requires positive integers');
    }
    return NumberToWords.convertOrdinal(languageCode, this.toInt());
  }

  /// Convert this number to ordinal words in English (explicit)
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinalEnglish()); // "first"
  /// print(21.toOrdinalEnglish()); // "twenty-first"
  /// ```
  String toOrdinalEnglish() {
    return toOrdinalInLanguage('en');
  }

  /// Convert this number to ordinal words in Vietnamese
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinalVietnamese()); // "thứ nhất"
  /// print(2.toOrdinalVietnamese()); // "thứ hai"
  /// ```
  String toOrdinalVietnamese() {
    return toOrdinalInLanguage('vi');
  }

  /// Convert this number to ordinal words in Spanish
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinalSpanish()); // "primero"
  /// print(2.toOrdinalSpanish()); // "segundo"
  /// ```
  String toOrdinalSpanish() {
    return toOrdinalInLanguage('es');
  }

  /// Convert this number to ordinal words in French
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinalFrench()); // "premier"
  /// print(2.toOrdinalFrench()); // "deuxième"
  /// ```
  String toOrdinalFrench() {
    return toOrdinalInLanguage('fr');
  }

  /// Convert this number to ordinal words in German
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinalGerman()); // "erste"
  /// print(2.toOrdinalGerman()); // "zweite"
  /// ```
  String toOrdinalGerman() {
    return toOrdinalInLanguage('de');
  }

  /// Convert this number to ordinal words in Italian
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinalItalian()); // "primo"
  /// print(2.toOrdinalItalian()); // "secondo"
  /// ```
  String toOrdinalItalian() {
    return toOrdinalInLanguage('it');
  }

  /// Convert this number to ordinal words in Portuguese
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinalPortuguese()); // "primeiro"
  /// print(2.toOrdinalPortuguese()); // "segundo"
  /// ```
  String toOrdinalPortuguese() {
    return toOrdinalInLanguage('pt');
  }

  /// Convert this number to ordinal words in Russian
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinalRussian()); // "первый"
  /// print(2.toOrdinalRussian()); // "второй"
  /// ```
  String toOrdinalRussian() {
    return toOrdinalInLanguage('ru');
  }

  /// Convert this number to ordinal words in Chinese
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinalChinese()); // "第一"
  /// print(2.toOrdinalChinese()); // "第二"
  /// ```
  String toOrdinalChinese() {
    return toOrdinalInLanguage('zh');
  }

  /// Convert this number to ordinal words in Japanese
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinalJapanese()); // "第いち番目"
  /// print(2.toOrdinalJapanese()); // "第に番目"
  /// ```
  String toOrdinalJapanese() {
    return toOrdinalInLanguage('ja');
  }

  /// Convert this number to ordinal words in Dutch
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinalDutch()); // "eerste"
  /// print(2.toOrdinalDutch()); // "tweede"
  /// ```
  String toOrdinalDutch() {
    return toOrdinalInLanguage('nl');
  }

  /// Convert this number to ordinal words in Arabic
  ///
  /// Example:
  /// ```dart
  /// print(1.toOrdinalArabic()); // "الأول"
  /// print(2.toOrdinalArabic()); // "الثاني"
  /// ```
  String toOrdinalArabic() {
    return toOrdinalInLanguage('ar');
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

  /// Convert this integer to ordinal words in the specified language
  /// 
  /// Specialized method for integers to convert to ordinal form.
  /// 
  /// Example:
  /// ```dart
  /// print(1.toOrdinalWords()); // "first"
  /// print(21.toOrdinalWords()); // "twenty-first"
  /// print(101.toOrdinalWords()); // "one hundred first"
  /// print(1.toOrdinalWords('vi')); // "thứ nhất"
  /// ```
  /// 
  /// **Throws:**
  /// - [ArgumentError] if the number is not positive
  String toOrdinalWords([String languageCode = 'en']) {
    if (this <= 0) {
      throw ArgumentError('Ordinal numbers must be positive integers');
    }
    return NumberToWords.convertOrdinal(languageCode, this);
  }

  /// Check if this integer can be converted to ordinal words
  /// 
  /// Returns true if the number is a positive integer.
  /// 
  /// Example:
  /// ```dart
  /// print(1.canConvertToOrdinal()); // true
  /// print(0.canConvertToOrdinal()); // false
  /// print((-1).canConvertToOrdinal()); // false
  /// ```
  bool canConvertToOrdinal() {
    return this > 0;
  }

  /// Get ordinal suffix for this number (English only)
  /// 
  /// Returns just the ordinal suffix (st, nd, rd, th).
  /// 
  /// Example:
  /// ```dart
  /// print(1.getOrdinalSuffix()); // "st"
  /// print(2.getOrdinalSuffix()); // "nd" 
  /// print(3.getOrdinalSuffix()); // "rd"
  /// print(11.getOrdinalSuffix()); // "th"
  /// print(21.getOrdinalSuffix()); // "st"
  /// ```
  String getOrdinalSuffix() {
    if (this <= 0) {
      throw ArgumentError('Ordinal suffix requires positive integers');
    }

    // Special cases for the teens
    int lastTwoDigits = this % 100;
    if (lastTwoDigits >= 11 && lastTwoDigits <= 13) {
      return 'th';
    }

    // Check last digit
    int lastDigit = this % 10;
    switch (lastDigit) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
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
