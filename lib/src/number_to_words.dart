import 'language_base.dart';
import 'languages/english.dart';
import 'languages/vietnamese.dart';
import 'languages/spanish.dart';
import 'languages/french.dart';
import 'languages/german.dart';
import 'languages/italian.dart';
import 'languages/portuguese.dart';
import 'languages/russian.dart';
import 'languages/chinese.dart';
import 'languages/japanese.dart';
import 'languages/dutch.dart';
import 'languages/arabic.dart';

/// Main NumberToWords class with multi-language support
///
/// This class provides a unified interface for converting numbers to words
/// in multiple languages. It manages language instances and provides
/// utility methods for language discovery.
class NumberToWords {
  // Private constructor to prevent instantiation
  NumberToWords._();

  /// Map of supported language implementations
  static final Map<String, NumberToWordsLanguage> _languages = {
    'en': EnglishNumberToWords(),
    'vi': VietnameseNumberToWords(),
    'es': SpanishNumberToWords(),
    'fr': FrenchNumberToWords(),
    'de': GermanNumberToWords(),
    'it': ItalianNumberToWords(),
    'pt': PortugueseNumberToWords(),
    'ru': RussianNumberToWords(),
    'zh': ChineseNumberToWords(),
    'ja': JapaneseNumberToWords(),
    'nl': DutchNumberToWords(),
    'ar': ArabicNumberToWords(),
  };

  /// Convert number to words in specified language
  ///
  /// [languageCode] - Language code ('en', 'vi', 'es')
  /// [number] - Number to convert (int or double)
  ///
  /// Example:
  /// ```dart
  /// NumberToWords.convert('en', 123); // "one hundred twenty-three"
  /// NumberToWords.convert('vi', 123); // "một trăm hai mươi ba"
  /// NumberToWords.convert('es', 123); // "ciento veintitrés"
  /// ```
  ///
  /// Throws [ArgumentError] if the language is not supported.
  static String convert(String languageCode, num number) {
    final language = _getLanguage(languageCode);
    return language.convert(number);
  }

  /// Convert decimal number string to words in specified language
  ///
  /// [languageCode] - Language code ('en', 'vi', 'es')
  /// [numberStr] - Number as string (e.g., "123.45", "-67.89")
  ///
  /// Example:
  /// ```dart
  /// NumberToWords.convertDecimal('en', '123.45');
  /// // "one hundred twenty-three point four five"
  /// ```
  ///
  /// Throws [ArgumentError] if the language is not supported or
  /// if the number string is invalid.
  static String convertDecimal(String languageCode, String numberStr) {
    final language = _getLanguage(languageCode);
    return language.convertDecimal(numberStr);
  }

  /// Get list of supported language codes
  ///
  /// Returns a list of language codes that this package supports.
  ///
  /// Example:
  /// ```dart
  /// List<String> codes = NumberToWords.supportedLanguages;
  /// // ['en', 'vi', 'es']
  /// ```
  static List<String> get supportedLanguages => _languages.keys.toList();

  /// Get map of supported language codes to their human-readable names
  ///
  /// Returns a map where keys are language codes and values are
  /// the human-readable language names.
  ///
  /// Example:
  /// ```dart
  /// Map<String, String> languages = NumberToWords.supportedLanguagesWithNames;
  /// // {'en': 'English', 'vi': 'Vietnamese', 'es': 'Spanish'}
  /// ```
  static Map<String, String> get supportedLanguagesWithNames {
    return Map.fromEntries(
        _languages.entries.map((e) => MapEntry(e.key, e.value.languageName)));
  }

  /// Check if a language is supported
  ///
  /// [languageCode] - Language code to check
  ///
  /// Returns `true` if the language is supported, `false` otherwise.
  /// The check is case-insensitive.
  ///
  /// Example:
  /// ```dart
  /// bool isSupported = NumberToWords.isLanguageSupported('en'); // true
  /// bool isSupported = NumberToWords.isLanguageSupported('fr'); // true
  /// bool isSupported = NumberToWords.isLanguageSupported('EN'); // true (case-insensitive)
  /// ```
  static bool isLanguageSupported(String languageCode) {
    return _languages.containsKey(languageCode.toLowerCase());
  }

  /// Convert an integer to ordinal words in specified language
  ///
  /// Converts numbers to their ordinal form (1st, 2nd, 3rd, etc.) in words.
  ///
  /// **Parameters:**
  /// - [languageCode] - Language code ('en', 'vi', 'es', 'fr', 'de', 'it', 'pt', 'ru', 'zh', 'ja', 'nl', 'ar')
  /// - [number] - Positive integer to convert to ordinal
  ///
  /// **Examples:**
  /// ```dart
  /// NumberToWords.convertOrdinal('en', 1);   // "first"
  /// NumberToWords.convertOrdinal('en', 2);   // "second"
  /// NumberToWords.convertOrdinal('en', 21);  // "twenty-first"
  /// NumberToWords.convertOrdinal('vi', 1);   // "thứ nhất"
  /// NumberToWords.convertOrdinal('fr', 1);   // "premier"
  /// NumberToWords.convertOrdinal('zh', 1);   // "第一"
  /// NumberToWords.convertOrdinal('ja', 1);   // "第いち番目"
  /// ```
  ///
  /// **Throws:**
  /// - [ArgumentError] if the language is not supported
  /// - [ArgumentError] if the number is not a positive integer
  static String convertOrdinal(String languageCode, int number) {
    final language = _languages[languageCode.toLowerCase()];
    if (language == null) {
      throw ArgumentError('Language "$languageCode" is not supported. '
          'Supported languages: ${_languages.keys.join(', ')}');
    }
    return language.convertOrdinal(number);
  }

  /// Convert a monetary amount to currency words in specified language
  ///
  /// Converts monetary amounts to their word representation including
  /// currency names and subunit handling (cents, pence, xu, etc.).
  ///
  /// **Parameters:**
  /// - [languageCode] - Language code ('en', 'vi', 'es', 'fr', 'de', 'it', 'pt', 'ru', 'zh', 'ja', 'nl', 'ar')
  /// - [amount] - Monetary amount (can include decimals)
  /// - [currencyCode] - ISO 4217 currency code (e.g., 'USD', 'EUR', 'VND')
  ///
  /// **Supported Currencies:**
  /// - USD (US Dollar), EUR (Euro), GBP (British Pound)
  /// - JPY (Japanese Yen), VND (Vietnamese Dong), CNY (Chinese Yuan)
  /// - KRW (Korean Won), THB (Thai Baht), SGD (Singapore Dollar)
  /// - AUD (Australian Dollar), CAD (Canadian Dollar), CHF (Swiss Franc)
  ///
  /// **Examples:**
  /// ```dart
  /// NumberToWords.convertCurrency('en', 123.45, 'USD');  // "one hundred twenty-three dollars and forty-five cents"
  /// NumberToWords.convertCurrency('vi', 123.45, 'VND');  // "một trăm hai mười ba đồng bốn mười lăm xu"
  /// NumberToWords.convertCurrency('en', 123, 'JPY');     // "one hundred twenty-three yen"
  /// NumberToWords.convertCurrency('fr', 123.45, 'EUR');  // "cent vingt-trois euros et quarante-cinq centimes"
  /// NumberToWords.convertCurrency('zh', 123.45, 'CNY');  // "一百二十三人民币四十五角"
  /// ```
  ///
  /// **Throws:**
  /// - [ArgumentError] if the language is not supported
  /// - [ArgumentError] if the currency code is not supported
  /// - [ArgumentError] if the amount is negative
  static String convertCurrency(
      String languageCode, double amount, String currencyCode) {
    final language = _languages[languageCode.toLowerCase()];
    if (language == null) {
      throw ArgumentError('Language "$languageCode" is not supported. '
          'Supported languages: ${_languages.keys.join(', ')}');
    }
    return language.convertCurrency(amount, currencyCode);
  }

  /// Get the language implementation for a given language code
  ///
  /// [languageCode] - Language code to get implementation for
  ///
  /// Returns the [NumberToWordsLanguage] implementation for the language.
  ///
  /// Throws [ArgumentError] if the language is not supported.
  static NumberToWordsLanguage getLanguage(String languageCode) {
    return _getLanguage(languageCode);
  }

  /// Register a new language implementation
  ///
  /// [language] - Language implementation to register
  ///
  /// This allows adding custom language implementations at runtime.
  ///
  /// Example:
  /// ```dart
  /// NumberToWords.registerLanguage(MyCustomLanguage());
  /// ```
  static void registerLanguage(NumberToWordsLanguage language) {
    _languages[language.languageCode] = language;
  }

  /// Remove a language implementation
  ///
  /// [languageCode] - Language code to remove
  ///
  /// Returns `true` if the language was removed, `false` if it wasn't found.
  ///
  /// Note: Built-in languages can be removed, but this is not recommended
  /// as it may break existing code.
  static bool unregisterLanguage(String languageCode) {
    return _languages.remove(languageCode.toLowerCase()) != null;
  }

  /// Get detailed information about all supported languages
  ///
  /// Returns a list of maps containing detailed information about each
  /// supported language.
  ///
  /// Example:
  /// ```dart
  /// List<Map<String, String>> info = NumberToWords.getLanguageInfo();
  /// // [
  /// //   {'code': 'en', 'name': 'English', 'minusWord': 'minus', 'pointWord': 'point'},
  /// //   {'code': 'vi', 'name': 'Vietnamese', 'minusWord': 'âm', 'pointWord': 'phẩy'},
  /// //   ...
  /// // ]
  /// ```
  static List<Map<String, String>> getLanguageInfo() {
    return _languages.values
        .map((lang) => {
              'code': lang.languageCode,
              'name': lang.languageName,
              'minusWord': lang.minusWord,
              'pointWord': lang.pointWord,
            })
        .toList();
  }

  /// Private helper method to get language implementation
  ///
  /// Handles case-insensitive lookup and error throwing.
  static NumberToWordsLanguage _getLanguage(String languageCode) {
    final language = _languages[languageCode.toLowerCase()];
    if (language == null) {
      throw ArgumentError('Language "$languageCode" is not supported. '
          'Supported languages: ${_languages.keys.join(', ')}');
    }
    return language;
  }
}
