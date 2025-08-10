# ChangeLog

## [3.0.3] - 2025-08-10

### 📚 Documentation Updates & Compatibility Improvements

#### 📝 README Synchronization
- **Updated dependency version**: Changed installation guide from `^3.0.0` to `^3.0.3`
- **Accurate test count**: Updated from "145+ tests" to precise "147 tests"
- **Added recent improvements**: Highlighted Vietnamese, Russian, Arabic grammar fixes
- **Added code quality notes**: Mentioned Dart formatting compliance improvements
- **Version consistency**: All documentation now matches actual package version

#### 📱 Broader Flutter Support
- **Relaxed SDK constraints**: Dart `>=2.12.0 <4.0.0` (was `>=3.0.0 <4.0.0`)
- **Relaxed Flutter constraints**: Flutter `>=2.5.0` (was `>=3.24.0`)
- **Backward compatibility**: Now supports older Flutter projects and legacy codebases
- **Wider adoption**: Compatible with Flutter 2.5+ to latest versions
- **Enterprise friendly**: Works with conservative enterprise Flutter versions

#### 🎯 User Experience
- **Clear installation instructions**: Users get the correct version for dependencies
- **Up-to-date feature list**: Recent language accuracy improvements documented
- **Better onboarding**: New users see current capabilities and improvements
- **Legacy project support**: Existing projects can now use the package without upgrading
- **Team flexibility**: Different team members can use different Flutter versions

## [3.0.2] - 2025-08-10

### 🔧 Code Quality & Formatting

#### 📝 Dart Formatting Fixes

- **Fixed code formatting**: Resolved Dart format issues in 2 files
  - `lib/src/languages/russian.dart` - Gender agreement implementation formatting
  - `test/number_to_words_vietnamese_additional_test.dart` - Test case formatting
- **Improved pub.dev score**: Better compliance with Dart style guidelines
- **CI/CD compatibility**: All `dart format --set-exit-if-changed .` checks now pass
- **Zero functional changes**: No breaking changes, all 147 tests continue to pass

#### 📊 Code Standards

- **Consistent formatting**: All files follow official Dart style guide
- **Better readability**: Improved code structure and indentation
- **Maintenance ready**: Easier for contributors to follow coding standards

## [3.0.1] - 2025-08-10

### 🐛 Bug Fixes & Quality Improvements

#### 🇻🇳 Vietnamese Language Corrections

- **Fixed number reading rules**:
  - 10 → "Mười" (capital M, proper pronunciation)
  - 15 → "mười lăm" (use "lăm" instead of "năm" after tens)
  - 20, 30, 40... → "hai mươi", "ba mươi", "bốn mươi" (use "mươi" for tens ≥ 20)
  - 21, 31, 41... → "hai mươi mốt" (use "mốt" instead of "một" after tens)
  - 24, 34, 44... → "hai mươi tư" (use "tư" instead of "bốn" after tens)
- **Hundreds with zero tens**: Use "lẻ" connector (105 → "một trăm lẻ năm")
- **Currency formatting**: Proper connector "và" (123.45 VND → "một trăm hai mươi ba đồng và bốn mươi lăm xu")
- **Decimal reading**: Use base digit names (123.45 → "... phẩy bốn năm")

#### 🌍 International Language Fixes

- **🇷🇺 Russian**: Fixed gender agreement for thousands
  - 1000 → "одна тысяча" (feminine form, was "один тысяча")
  - Proper gender forms for 1-2 with feminine nouns
- **🇸🇦 Arabic**: Corrected number order and connectors
  - 21 → "واحد وعشرون" (ones before tens, was "عشرون واحد")
  - 123 → "مائة وثلاثة وعشرون" (proper "و" connectors)
  - Fixed word order according to Arabic grammar rules

#### 📦 Pub.dev Score Improvements

- **Optimized package description**: Reduced from 201 to 127 characters (within 60-180 range)
- **Fixed issue tracker URL**: Verified GitHub issues URL accessibility
- **Enhanced package metadata**: Better compliance with Dart package conventions

#### 🧪 Testing Enhancements

- **Added Vietnamese-specific tests**: Comprehensive coverage for new pronunciation rules
- **Updated all Vietnamese test expectations**: Aligned with corrected grammar
- **Cross-language validation**: Verified all 12 languages maintain accuracy

### 📊 Code Quality

- **Zero breaking changes**: All existing APIs remain fully compatible
- **147 test cases pass**: Complete validation across all languages
- **Improved documentation**: Updated examples with correct Vietnamese forms
- **Better pub.dev compliance**: Enhanced package scoring potential

## [3.0.0] - 2024-07-27

### 🚀 Architecture Refactoring & Extension Methods + 🥇 Ordinal Numbers + 💰 Currency Conversion

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

#### 💰 NEW: Currency Conversion Support

- **12 major currencies**: USD, EUR, GBP, JPY, VND, CNY, KRW, THB, SGD, AUD, CAD, CHF
- **New API method**: `NumberToWords.convertCurrency(languageCode, amount, currencyCode)`
- **Currency extension methods**: `toCurrency()`, `toUSD()`, `toEUR()`, `toVND()`, `toCNY()`, etc.
- **Multi-language currency names**: Proper currency names in all 12 languages
- **Subunit handling**: Automatic cents, pence, xu, jiao, etc. for appropriate currencies
- **No-decimal currencies**: Special handling for JPY, KRW (no subunits)
- **Smart plural forms**: Proper singular/plural currency names (dollar vs dollars)
- **Localized connectors**: "and" (EN), "et" (FR), "y" (ES), "und" (DE), "و" (AR), etc.

#### 📚 Enhanced Documentation

- **Comprehensive API documentation**: Every method has detailed docs with examples
- **Library-level documentation**: Clear usage guide in main library file
- **Migration guide**: Step-by-step guide for upgrading from legacy API
- **Interactive example app**: Showcases all new extension methods and APIs

#### 🧪 Comprehensive Testing

- **145 test cases**: Complete coverage of all features including ordinals and currency
- **15 new ordinal tests**: Dedicated coverage for all ordinal functionality
- **15 new currency tests**: Complete currency conversion testing across all languages
- **Extension method tests**: Dedicated test groups for each extension type
- **Architecture tests**: Validation of modular design
- **Edge case handling**: Robust error handling and validation

### 📱 Example App Enhancements

- **Extension methods demo**: Interactive showcase of all extension methods
- **🆕 Ordinal numbers demo**: Real-time ordinal conversion in all 12 languages
- **🆕 Currency conversion demo**: Interactive currency conversion with all supported currencies
- **Real-time examples**: Dynamic code examples that update with user input
- **Multi-API comparison**: Side-by-side comparison of different APIs
- **Smart UI**: Ordinals only shown for positive integers, currency shown for all numbers
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
