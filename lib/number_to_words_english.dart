// Export all public APIs
export 'src/number_to_words.dart';
export 'src/extensions.dart';
export 'src/language_base.dart';

// Export language implementations for advanced usage
export 'src/languages/english.dart';
export 'src/languages/vietnamese.dart';
export 'src/languages/spanish.dart';
export 'src/languages/french.dart';
export 'src/languages/german.dart';
export 'src/languages/italian.dart';
export 'src/languages/portuguese.dart';
export 'src/languages/russian.dart';
export 'src/languages/chinese.dart';
export 'src/languages/japanese.dart';
export 'src/languages/dutch.dart';
export 'src/languages/arabic.dart';

// Legacy API for backward compatibility
import 'src/languages/english.dart';

/// A comprehensive Flutter/Dart package that converts numbers to words with support for 12 languages worldwide.
///
/// This library provides comprehensive number-to-words conversion functionality
/// with support for 12 languages including English, Vietnamese, Spanish, French, German,
/// Italian, Portuguese, Russian, Chinese, Japanese, Dutch, and Arabic.
///
/// ## Features
///
/// - **Comprehensive multi-language support**: 12 languages worldwide
/// - **Extension methods**: Convert numbers directly using `.toWords()`, `.toFrench()`, etc.
/// - **Global coverage**: Europe, Asia, Middle East, Latin America
/// - **Flexible API**: Both static methods and extension methods
/// - **Modular architecture**: Separate implementation for each language
/// - **Backward compatible**: Existing `NumberToWordsEnglish` API still works
/// - **Extensible**: Easy to add new language implementations
///
/// ## Basic Usage
///
/// ```dart
/// import 'package:number_to_words_english/number_to_words_english.dart';
///
/// // Using the new multi-language API
/// print(NumberToWords.convert('en', 123)); // "one hundred twenty-three"
/// print(NumberToWords.convert('vi', 123)); // "một trăm hai mười ba"
/// print(NumberToWords.convert('es', 123)); // "ciento veintitrés"
///
/// // Using extension methods
/// print(123.toWords()); // "one hundred twenty-three"
/// print(123.toVietnamese()); // "một trăm hai mười ba"
/// print(123.toSpanish()); // "ciento veintitrés"
/// print(123.toFrench()); // "cent vingt-trois"
/// print(123.toGerman()); // "einhundertdreiundzwanzig"
/// print(123.toChinese()); // "一百二十三"
/// print(123.toJapanese()); // "ひゃくにじゅうさん"
/// print(123.toArabic()); // "مائة ثلاثة وعشرون"
///
/// // Legacy API (still supported)
/// print(NumberToWordsEnglish.convert(123)); // "one hundred twenty-three"
/// ```
///
/// ## Supported Languages (12 Total)
///
/// | Code | Language | Example (123) | Region |
/// |------|----------|---------------|--------|
/// | `en` | English | one hundred twenty-three | Global |
/// | `vi` | Vietnamese | một trăm hai mười ba | Southeast Asia |
/// | `es` | Spanish | ciento veintitrés | Latin America |
/// | `fr` | French | cent vingt-trois | Europe |
/// | `de` | German | einhundertdreiundzwanzig | Europe |
/// | `it` | Italian | centoventitre | Europe |
/// | `pt` | Portuguese | cento e vinte e três | Latin America |
/// | `ru` | Russian | сто двадцать три | Eastern Europe |
/// | `zh` | Chinese | 一百二十三 | East Asia |
/// | `ja` | Japanese | ひゃくにじゅうさん | East Asia |
/// | `nl` | Dutch | honderddrieëntwintig | Europe |
/// | `ar` | Arabic | مائة ثلاثة وعشرون | Middle East |

/// Legacy class for backward compatibility
///
/// This class maintains the original API for existing users.
/// For new projects, consider using [NumberToWords] class instead.
///
/// ## Migration Guide
///
/// **Old API:**
/// ```dart
/// NumberToWordsEnglish.convert(123); // "one hundred twenty-three"
/// ```
///
/// **New API (recommended):**
/// ```dart
/// NumberToWords.convert('en', 123); // "one hundred twenty-three"
/// // or using extensions:
/// 123.toWords(); // "one hundred twenty-three"
/// ```
class NumberToWordsEnglish {
  NumberToWordsEnglish._();

  static final EnglishNumberToWords _english = EnglishNumberToWords();

  /// Convert a number to English words
  ///
  /// This method is maintained for backward compatibility.
  /// For new projects, use [NumberToWords.convert('en', number)] instead.
  ///
  /// Example:
  /// ```dart
  /// String result = NumberToWordsEnglish.convert(123);
  /// // Returns: "one hundred twenty-three"
  /// ```
  ///
  /// **Parameters:**
  /// - [number] - The number to convert (supports both int and double)
  ///
  /// **Returns:**
  /// - String representation of the number in English words
  static String convert(num number) {
    return _english.convert(number);
  }

  /// Convert a decimal number string to English words
  ///
  /// This method is maintained for backward compatibility.
  /// For new projects, use [NumberToWords.convertDecimal('en', numberStr)] instead.
  ///
  /// Example:
  /// ```dart
  /// String result = NumberToWordsEnglish.convertDecimal("123.45");
  /// // Returns: "one hundred twenty-three point four five"
  /// ```
  ///
  /// **Parameters:**
  /// - [numberStr] - String representation of the number
  ///
  /// **Returns:**
  /// - String representation of the number in English words
  ///
  /// **Throws:**
  /// - [ArgumentError] if the input string is not a valid number
  static String convertDecimal(String numberStr) {
    return _english.convertDecimal(numberStr);
  }
}
