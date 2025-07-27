# ChangeLog

## [3.0.0] - 2024-07-27

### 🚀 Architecture Refactoring & Extension Methods + 🥇 Ordinal Numbers

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

#### 🥇 NEW: Ordinal Numbers Support

- **Full ordinal support**: Convert numbers to ordinal form (1st, 2nd, 3rd, etc.) in all 12 languages
- **New API method**: `NumberToWords.convertOrdinal(languageCode, number)`
- **Complete extension methods**: `toOrdinal()`, `toOrdinalVietnamese()`, `toOrdinalFrench()`, etc.
- **Smart English ordinals**: Proper irregular forms (first, second, third, eleventh, twelfth, twenty-first)
- **Integer-specific methods**: `toOrdinalWords()`, `getOrdinalSuffix()`, `canConvertToOrdinal()`
- **Global coverage**: All 12 languages support ordinal conversion with culturally appropriate forms

#### 📚 Enhanced Documentation

- **Comprehensive API documentation**: Every method has detailed docs with examples
- **Library-level documentation**: Clear usage guide in main library file
- **Migration guide**: Step-by-step guide for upgrading from legacy API
- **Interactive example app**: Showcases all new extension methods and APIs

#### 🧪 Comprehensive Testing

- **103 test cases**: Complete coverage of all features including ordinals
- **15 new ordinal tests**: Dedicated coverage for all ordinal functionality
- **Extension method tests**: Dedicated test groups for each extension type
- **Architecture tests**: Validation of modular design
- **Edge case handling**: Robust error handling and validation

### 📱 Example App Enhancements

- **Extension methods demo**: Interactive showcase of all extension methods
- **🆕 Ordinal numbers demo**: Real-time ordinal conversion in all 12 languages
- **Real-time examples**: Dynamic code examples that update with user input
- **Multi-API comparison**: Side-by-side comparison of different APIs
- **Smart UI**: Ordinals only shown for positive integers
- **Better UI**: Modern Material Design 3 interface

### 🔄 Backward Compatibility

- **100% compatible**: All existing code continues to work unchanged
- **Legacy API preserved**: `NumberToWordsEnglish` class remains fully functional
- **Smooth migration path**: Clear examples showing old vs new API usage

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
