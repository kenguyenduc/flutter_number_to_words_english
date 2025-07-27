# ChangeLog

## [3.1.0] - 2024-07-27

### 🚀 Architecture Refactoring & Extension Methods

#### 🏗️ Modular Architecture

- **Separated language implementations**: Each language now has its own dedicated file
  - `lib/src/languages/english.dart` - English implementation
  - `lib/src/languages/vietnamese.dart` - Vietnamese implementation
  - `lib/src/languages/spanish.dart` - Spanish implementation
- **Abstract base class**: `NumberToWordsLanguage` provides common interface for all languages
- **Main API class**: `NumberToWords` manages all language implementations
- **Clean exports**: Main library file exports all public APIs with proper documentation

#### ✨ Extension Methods

- **`num.toWords()`**: Convert any number to English words directly
- **Language-specific extensions**:
  - `num.toEnglish()` - Convert to English
  - `num.toVietnamese()` - Convert to Vietnamese
  - `num.toSpanish()` - Convert to Spanish
  - `num.toWordsInLanguage(String code)` - Convert to any supported language
- **Integer-specific extensions**:
  - `int.toCardinal()` - Cardinal number conversion
  - `int.canConvertToWords()` - Validation method
  - `int.wordLength()` - Get character count of word representation
  - `int.wordCount()` - Get word count of representation
- **Double-specific extensions**:
  - `double.toWordsWithDecimal()` - Explicit decimal conversion
  - `double.integerPartToWords()` - Convert only integer part
  - `double.decimalPartToWords()` - Convert only decimal digits
- **String extensions**:
  - `String.toWordsFromString()` - Convert number strings to words
  - `String.isValidNumberString()` - Validate number strings
  - `String.toWordsInMultipleLanguages()` - Convert to multiple languages at once

#### 🔧 Advanced Features

- **Dynamic language registration**: `NumberToWords.registerLanguage()`
- **Language introspection**: `NumberToWords.getLanguageInfo()`
- **Direct language access**: `NumberToWords.getLanguage()`
- **Runtime language management**: Register/unregister languages dynamically

#### 📚 Enhanced Documentation

- **Comprehensive API documentation**: Every method has detailed docs with examples
- **Library-level documentation**: Clear usage guide in main library file
- **Migration guide**: Step-by-step guide for upgrading from legacy API
- **Interactive example app**: Showcases all new extension methods and APIs

#### 🧪 Comprehensive Testing

- **79 test cases**: Complete coverage of all features
- **Extension method tests**: Dedicated test groups for each extension type
- **Architecture tests**: Validation of modular design
- **Edge case handling**: Robust error handling and validation

### 📱 Example App Enhancements

- **Extension methods demo**: Interactive showcase of all extension methods
- **Real-time examples**: Dynamic code examples that update with user input
- **Multi-API comparison**: Side-by-side comparison of different APIs
- **Better UI**: Modern Material Design 3 interface

### 🔄 Backward Compatibility

- **100% compatible**: All existing code continues to work unchanged
- **Legacy API preserved**: `NumberToWordsEnglish` class remains fully functional
- **Smooth migration path**: Clear examples showing old vs new API usage

## [3.0.0] - 2024-07-27

### 🎉 Major Features

- **Comprehensive multi-language support**: Added support for 12 languages worldwide
- **Extension methods**: Direct number conversion with `.toWords()`, `.toFrench()`, etc.
- **Modular architecture**: Separated language implementations for better maintainability
- **Global coverage**: Support for major languages across Europe, Asia, Middle East, and Latin America

### ✨ New APIs

- `NumberToWords.convert(String languageCode, num number)` - Convert numbers in 12 languages
- `NumberToWords.convertDecimal(String languageCode, String numberStr)` - Convert decimal strings
- `NumberToWords.supportedLanguages` - Get list of all 12 supported language codes
- `NumberToWords.supportedLanguagesWithNames` - Get language codes with human-readable names
- `NumberToWords.isLanguageSupported(String languageCode)` - Check language support
- **Extension methods**: `123.toWords()`, `123.toFrench()`, `123.toGerman()`, etc.

### 🌍 Supported Languages (12 Total)

- **English (en)**: `NumberToWords.convert('en', 123)` → "one hundred twenty-three"
- **Vietnamese (vi)**: `NumberToWords.convert('vi', 123)` → "một trăm hai mười ba"
- **Spanish (es)**: `NumberToWords.convert('es', 123)` → "ciento veintitrés"
- **French (fr)**: `NumberToWords.convert('fr', 123)` → "cent vingt-trois"
- **German (de)**: `NumberToWords.convert('de', 123)` → "einhundertdreiundzwanzig"
- **Italian (it)**: `NumberToWords.convert('it', 123)` → "centoventitre"
- **Portuguese (pt)**: `NumberToWords.convert('pt', 123)` → "cento e vinte e três"
- **Russian (ru)**: `NumberToWords.convert('ru', 123)` → "сто двадцать три"
- **Chinese (zh)**: `NumberToWords.convert('zh', 123)` → "一百二十三"
- **Japanese (ja)**: `NumberToWords.convert('ja', 123)` → "ひゃくにじゅうさん"
- **Dutch (nl)**: `NumberToWords.convert('nl', 123)` → "honderddrieëntwintig"
- **Arabic (ar)**: `NumberToWords.convert('ar', 123)` → "مائة ثلاثة وعشرون"

### 🔄 Backward Compatibility

- **Legacy API preserved**: `NumberToWordsEnglish.convert()` continues to work unchanged
- **Zero breaking changes**: Existing code requires no modifications
- **Smooth migration**: Old API redirects to new English implementation

### 🏗️ Architecture Improvements

- **Abstract base class**: `NumberToWordsLanguage` for extensible language support
- **Modular design**: Separate implementations for each language
- **Performance optimized**: Efficient number processing algorithms
- **Well tested**: 59 comprehensive test cases covering all languages

### 📚 Documentation & Examples

- **Updated README**: Comprehensive multi-language examples and API documentation
- **Example app**: Interactive demo showcasing all supported languages
- **Migration guide**: Clear instructions for upgrading from legacy API

### 🧪 Testing

- **59 test cases**: Covering all languages, edge cases, and API compatibility
- **Language-specific tests**: Validation of number conversion rules for each language
- **Backward compatibility tests**: Ensures legacy API continues to function

## [2.1.0]

- [new] Update support for large integers up to quintillion.

## [2.0.2]

- fix ios build error

## [2.0.1]

- fix formatting issues

## [0.0.3]

- update changelog

## [0.0.2]

- Readme fixes

## [0.0.1]

- Initial release
