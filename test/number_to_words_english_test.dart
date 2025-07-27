import 'package:flutter_test/flutter_test.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

void main() {
  group('NumberToWordsEnglish (Legacy API)', () {
    final List<MapEntry<num, String>> testNumbers = <MapEntry<num, String>>[
      const MapEntry(1, 'one'),
      const MapEntry(2, 'two'),
      const MapEntry(3, 'three'),
      const MapEntry(4, 'four'),
      const MapEntry(5, 'five'),
      const MapEntry(6, 'six'),
      const MapEntry(7, 'seven'),
      const MapEntry(8, 'eight'),
      const MapEntry(9, 'nine'),
      const MapEntry(10, 'ten'),
      const MapEntry(11, 'eleven'),
      const MapEntry(12, 'twelve'),
      const MapEntry(13, 'thirteen'),
      const MapEntry(14, 'fourteen'),
      const MapEntry(15, 'fifteen'),
      const MapEntry(16, 'sixteen'),
      const MapEntry(17, 'seventeen'),
      const MapEntry(18, 'eighteen'),
      const MapEntry(19, 'nineteen'),
      const MapEntry(20, 'twenty'),
      const MapEntry(25, 'twenty-five'),
      const MapEntry(45, 'forty-five'),
      const MapEntry(55, 'fifty-five'),
      const MapEntry(100, 'one hundred'),
      const MapEntry(1000, 'one thousand'),
      const MapEntry(10000, 'ten thousand'),
      const MapEntry(100000, 'one hundred thousand'),
      const MapEntry(1000000, 'one million'),
      const MapEntry(1500000, 'one million five hundred thousand'),
      const MapEntry(100000000, 'one hundred million'),
      const MapEntry(1000000000, 'one billion'),
      const MapEntry(13578921,
          'thirteen million five hundred seventy-eight thousand nine hundred twenty-one'),
      const MapEntry(-13578921,
          'minus thirteen million five hundred seventy-eight thousand nine hundred twenty-one'),
      const MapEntry(123, 'one hundred twenty-three'),
      const MapEntry(-123.45, 'minus one hundred twenty-three point four five'),
      const MapEntry(123.45, 'one hundred twenty-three point four five'),
      const MapEntry(5553456987345,
          'five trillion five hundred fifty-three billion four hundred fifty-six million nine hundred eighty-seven thousand three hundred forty-five'),
      const MapEntry(5553456987345.123,
          'five trillion five hundred fifty-three billion four hundred fifty-six million nine hundred eighty-seven thousand three hundred forty-five point one two three'),
      const MapEntry(123456789,
          'one hundred twenty-three million four hundred fifty-six thousand seven hundred eighty-nine'),
      const MapEntry(9223372036854775807,
          'nine quintillion two hundred twenty-three quadrillion three hundred seventy-two trillion thirty-six billion eight hundred fifty-four million seven hundred seventy-five thousand eight hundred seven'),
    ];

    for (int i = 0; i < testNumbers.length; i++) {
      test('Legacy API TestCase ${i + 1}', () {
        String words = NumberToWordsEnglish.convert(testNumbers[i].key);
        expect(words, testNumbers[i].value);
      });
    }
  });

  group('NumberToWords Multi-Language Support', () {
    test('Supported languages', () {
      final languages = NumberToWords.supportedLanguages;
      expect(languages, contains('en'));
      expect(languages, contains('vi'));
      expect(languages, contains('es'));
      expect(languages, contains('fr'));
      expect(languages, contains('de'));
      expect(languages, contains('it'));
      expect(languages, contains('pt'));
      expect(languages, contains('ru'));
      expect(languages, contains('zh'));
      expect(languages, contains('ja'));
      expect(languages, contains('nl'));
      expect(languages, contains('ar'));
      expect(languages.length, 12); // Total languages
    });

    test('Language names', () {
      final languageNames = NumberToWords.supportedLanguagesWithNames;
      expect(languageNames['en'], 'English');
      expect(languageNames['vi'], 'Vietnamese');
      expect(languageNames['es'], 'Spanish');
      expect(languageNames['fr'], 'French');
      expect(languageNames['de'], 'German');
      expect(languageNames['it'], 'Italian');
      expect(languageNames['pt'], 'Portuguese');
      expect(languageNames['ru'], 'Russian');
      expect(languageNames['zh'], 'Chinese');
      expect(languageNames['ja'], 'Japanese');
      expect(languageNames['nl'], 'Dutch');
      expect(languageNames['ar'], 'Arabic');
    });

    test('Language support check', () {
      expect(NumberToWords.isLanguageSupported('en'), true);
      expect(NumberToWords.isLanguageSupported('vi'), true);
      expect(NumberToWords.isLanguageSupported('es'), true);
      expect(NumberToWords.isLanguageSupported('fr'), true);
      expect(NumberToWords.isLanguageSupported('de'), true);
      expect(NumberToWords.isLanguageSupported('it'), true);
      expect(NumberToWords.isLanguageSupported('pt'), true);
      expect(NumberToWords.isLanguageSupported('ru'), true);
      expect(NumberToWords.isLanguageSupported('zh'), true);
      expect(NumberToWords.isLanguageSupported('ja'), true);
      expect(NumberToWords.isLanguageSupported('nl'), true);
      expect(NumberToWords.isLanguageSupported('ar'), true);
      expect(NumberToWords.isLanguageSupported('unknown'), false);
    });

    test('Unsupported language throws error', () {
      expect(
        () => NumberToWords.convert('unsupported', 123),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Get language info', () {
      final info = NumberToWords.getLanguageInfo();
      expect(info.length, 12);
      expect(info.any((lang) => lang['code'] == 'en'), true);
      expect(info.any((lang) => lang['code'] == 'vi'), true);
      expect(info.any((lang) => lang['code'] == 'es'), true);
      expect(info.any((lang) => lang['code'] == 'fr'), true);
      expect(info.any((lang) => lang['code'] == 'de'), true);
      expect(info.any((lang) => lang['code'] == 'it'), true);
      expect(info.any((lang) => lang['code'] == 'pt'), true);
      expect(info.any((lang) => lang['code'] == 'ru'), true);
      expect(info.any((lang) => lang['code'] == 'zh'), true);
      expect(info.any((lang) => lang['code'] == 'ja'), true);
      expect(info.any((lang) => lang['code'] == 'nl'), true);
      expect(info.any((lang) => lang['code'] == 'ar'), true);
    });

    test('Register and unregister language', () {
      // Create a simple test language
      final testLang = EnglishNumberToWords();

      NumberToWords.registerLanguage(testLang);
      expect(NumberToWords.isLanguageSupported('en'), true);

      // Can't easily test unregistering without affecting other tests
      // So we'll just test the method exists and returns a boolean
      expect(NumberToWords.unregisterLanguage('nonexistent'), false);
    });
  });

  group('Extension Methods - Basic Conversion', () {
    test('toWords() extension', () {
      expect(123.toWords(), 'one hundred twenty-three');
      expect((-45).toWords(), 'minus forty-five');
      expect(12.34.toWords(), 'twelve point three four');
    });

    test('toWordsInLanguage() extension', () {
      expect(123.toWordsInLanguage('en'), 'one hundred twenty-three');
      expect(123.toWordsInLanguage('vi'), 'một trăm hai mười ba');
      expect(123.toWordsInLanguage('es'), 'ciento veintitrés');
    });

    test('Language-specific extension methods', () {
      expect(123.toEnglish(), 'one hundred twenty-three');
      expect(123.toVietnamese(), 'một trăm hai mười ba');
      expect(123.toSpanish(), 'ciento veintitrés');
      expect(123.toFrench(), isNotEmpty);
      expect(123.toGerman(), isNotEmpty);
      expect(123.toItalian(), isNotEmpty);
      expect(123.toPortuguese(), isNotEmpty);
      expect(123.toRussian(), isNotEmpty);
      expect(123.toChinese(), isNotEmpty);
      expect(123.toJapanese(), isNotEmpty);
      expect(123.toDutch(), isNotEmpty);
      expect(123.toArabic(), isNotEmpty);
    });
  });

  group('Extension Methods - Integer Specific', () {
    test('toCardinal() extension', () {
      expect(1.toCardinal(), 'one');
      expect(21.toCardinal(), 'twenty-one');
      expect(123.toCardinal('vi'), 'một trăm hai mười ba');
    });

    test('canConvertToWords() extension', () {
      expect(123.canConvertToWords(), true);
      expect(999999999999999.canConvertToWords(), true);
      expect((-123).canConvertToWords(), true);
    });

    test('wordLength() extension', () {
      expect(123.wordLength() > 0, true);
      expect(21.wordLength() > 0, true);
    });

    test('wordCount() extension', () {
      expect(123.wordCount(), 3); // "one hundred twenty-three" = 3 words
      expect(21.wordCount(), 1); // "twenty-one" (hyphenated)
    });
  });

  group('Extension Methods - Double Specific', () {
    test('toWordsWithDecimal() extension', () {
      expect(12.34.toWordsWithDecimal(), 'twelve point three four');
      expect((-12.34).toWordsWithDecimal(), 'minus twelve point three four');
    });

    test('integerPartToWords() extension', () {
      expect(12.34.integerPartToWords(), 'twelve');
      expect((-12.34).integerPartToWords(), 'minus twelve');
    });

    test('decimalPartToWords() extension', () {
      expect(12.34.decimalPartToWords(), 'three four');
      expect(12.05.decimalPartToWords(), 'zero five');
      expect(12.0.decimalPartToWords(), ''); // No decimal part
    });
  });

  group('Extension Methods - String Number Conversion', () {
    test('toWordsFromString() extension', () {
      expect("123".toWordsFromString(), 'one hundred twenty-three');
      expect("123.45".toWordsFromString(),
          'one hundred twenty-three point four five');
      expect("-123.45".toWordsFromString(),
          'minus one hundred twenty-three point four five');
    });

    test('isValidNumberString() extension', () {
      expect("123".isValidNumberString(), true);
      expect("12.34".isValidNumberString(), true);
      expect("-123.45".isValidNumberString(), true);
      expect("abc".isValidNumberString(), false);
      expect("12.34.56".isValidNumberString(), false);
    });

    test('toWordsInMultipleLanguages() extension', () {
      final results = "123".toWordsInMultipleLanguages(['en', 'vi', 'es']);
      expect(results['en'], 'one hundred twenty-three');
      expect(results['vi'], 'một trăm hai mười ba');
      expect(results['es'], 'ciento veintitrés');

      // Test with invalid language
      final resultsWithError =
          "123".toWordsInMultipleLanguages(['en', 'unsupported']);
      expect(resultsWithError['en'], 'one hundred twenty-three');
      expect(resultsWithError['unsupported']?.startsWith('Error:'), true);
    });
  });

  group('English Language Tests', () {
    test('Basic numbers', () {
      expect(NumberToWords.convert('en', 1), 'one');
      expect(NumberToWords.convert('en', 21), 'twenty-one');
      expect(NumberToWords.convert('en', 100), 'one hundred');
      expect(NumberToWords.convert('en', 1000), 'one thousand');
    });

    test('Negative numbers', () {
      expect(NumberToWords.convert('en', -5), 'minus five');
      expect(
          NumberToWords.convert('en', -123), 'minus one hundred twenty-three');
    });

    test('Decimal numbers', () {
      expect(NumberToWords.convert('en', 12.34), 'twelve point three four');
      expect(
          NumberToWords.convert('en', -12.34), 'minus twelve point three four');
    });
  });

  group('Vietnamese Language Tests', () {
    test('Basic numbers', () {
      expect(NumberToWords.convert('vi', 0), 'không');
      expect(NumberToWords.convert('vi', 1), 'một');
      expect(NumberToWords.convert('vi', 5), 'năm');
      expect(NumberToWords.convert('vi', 10), 'mười');
      expect(NumberToWords.convert('vi', 15), 'mười năm');
      expect(NumberToWords.convert('vi', 21), 'hai mười một');
      expect(NumberToWords.convert('vi', 100), 'một trăm');
      expect(NumberToWords.convert('vi', 123), 'một trăm hai mười ba');
      expect(NumberToWords.convert('vi', 1000), 'một nghìn');
    });

    test('Large numbers', () {
      expect(NumberToWords.convert('vi', 1000000), 'một triệu');
      expect(NumberToWords.convert('vi', 1000000000), 'một tỷ');
    });

    test('Negative numbers', () {
      expect(NumberToWords.convert('vi', -5), 'âm năm');
      expect(NumberToWords.convert('vi', -123), 'âm một trăm hai mười ba');
    });

    test('Decimal numbers', () {
      expect(NumberToWords.convert('vi', 12.34), 'mười hai phẩy ba tư');
      expect(NumberToWords.convert('vi', -12.34), 'âm mười hai phẩy ba tư');
    });
  });

  group('Spanish Language Tests', () {
    test('Basic numbers', () {
      expect(NumberToWords.convert('es', 0), 'cero');
      expect(NumberToWords.convert('es', 1), 'uno');
      expect(NumberToWords.convert('es', 5), 'cinco');
      expect(NumberToWords.convert('es', 10), 'diez');
      expect(NumberToWords.convert('es', 15), 'quince');
      expect(NumberToWords.convert('es', 21), 'veintiuno');
      expect(NumberToWords.convert('es', 100), 'cien');
      expect(NumberToWords.convert('es', 123), 'ciento veintitrés');
      expect(NumberToWords.convert('es', 1000), 'mil');
    });

    test('Negative numbers', () {
      expect(NumberToWords.convert('es', -5), 'menos cinco');
      expect(NumberToWords.convert('es', -123), 'menos ciento veintitrés');
    });

    test('Decimal numbers', () {
      expect(NumberToWords.convert('es', 12.34), 'doce punto tres cuatro');
      expect(
          NumberToWords.convert('es', -12.34), 'menos doce punto tres cuatro');
    });
  });

  group('Decimal String Conversion', () {
    test('English decimal strings', () {
      expect(NumberToWords.convertDecimal('en', '123.45'),
          'one hundred twenty-three point four five');
      expect(NumberToWords.convertDecimal('en', '-123.45'),
          'minus one hundred twenty-three point four five');
    });

    test('Vietnamese decimal strings', () {
      expect(NumberToWords.convertDecimal('vi', '123.45'),
          'một trăm hai mười ba phẩy tư năm');
      expect(NumberToWords.convertDecimal('vi', '-123.45'),
          'âm một trăm hai mười ba phẩy tư năm');
    });

    test('Spanish decimal strings', () {
      expect(NumberToWords.convertDecimal('es', '123.45'),
          'ciento veintitrés punto cuatro cinco');
      expect(NumberToWords.convertDecimal('es', '-123.45'),
          'menos ciento veintitrés punto cuatro cinco');
    });

    test('Invalid decimal string throws error', () {
      expect(
        () => NumberToWords.convertDecimal('en', 'notanumber'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Additional Language Tests', () {
    test('French basic numbers', () {
      expect(NumberToWords.convert('fr', 0), 'zéro');
      expect(NumberToWords.convert('fr', 1), 'un');
      expect(NumberToWords.convert('fr', 21), isNotEmpty);
      expect(NumberToWords.convert('fr', 100), 'cent');
    });

    test('German basic numbers', () {
      expect(NumberToWords.convert('de', 0), 'null');
      expect(NumberToWords.convert('de', 1), 'eins');
      expect(NumberToWords.convert('de', 21), 'einundzwanzig');
    });

    test('Italian basic numbers', () {
      expect(NumberToWords.convert('it', 0), 'zero');
      expect(NumberToWords.convert('it', 1), 'uno');
      expect(NumberToWords.convert('it', 100), 'cento');
    });

    test('Portuguese basic numbers', () {
      expect(NumberToWords.convert('pt', 0), 'zero');
      expect(NumberToWords.convert('pt', 1), 'um');
      expect(NumberToWords.convert('pt', 100), 'cem');
    });

    test('Russian basic numbers', () {
      expect(NumberToWords.convert('ru', 0), 'ноль');
      expect(NumberToWords.convert('ru', 1), 'один');
      expect(NumberToWords.convert('ru', 100), 'сто');
    });

    test('Chinese basic numbers', () {
      expect(NumberToWords.convert('zh', 0), '零');
      expect(NumberToWords.convert('zh', 1), '一');
      expect(NumberToWords.convert('zh', 10), '十');
    });

    test('Japanese basic numbers', () {
      expect(NumberToWords.convert('ja', 0), 'ゼロ');
      expect(NumberToWords.convert('ja', 1), 'いち');
      expect(NumberToWords.convert('ja', 10), 'じゅう');
    });

    test('Dutch basic numbers', () {
      expect(NumberToWords.convert('nl', 0), 'nul');
      expect(NumberToWords.convert('nl', 1), 'een');
      expect(NumberToWords.convert('nl', 21), 'eenentwintig');
    });

    test('Arabic basic numbers', () {
      expect(NumberToWords.convert('ar', 0), 'صفر');
      expect(NumberToWords.convert('ar', 1), 'واحد');
      expect(NumberToWords.convert('ar', 100), 'مائة');
    });
  });

  group('Case Insensitivity', () {
    test('Language codes are case insensitive', () {
      expect(NumberToWords.convert('EN', 123), 'one hundred twenty-three');
      expect(NumberToWords.convert('Vi', 123), 'một trăm hai mười ba');
      expect(NumberToWords.convert('ES', 123), 'ciento veintitrés');
    });
  });

  group('Architecture Tests', () {
    test('Language base class methods', () {
      final english = EnglishNumberToWords();
      expect(english.languageCode, 'en');
      expect(english.languageName, 'English');
      expect(english.minusWord, 'minus');
      expect(english.pointWord, 'point');
      expect(english.isValidNumber('123'), true);
      expect(english.isValidNumber('abc'), false);
    });

    test('Direct language access', () {
      final english = NumberToWords.getLanguage('en');
      expect(english.convert(123), 'one hundred twenty-three');

      expect(
        () => NumberToWords.getLanguage('invalid'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Edge Cases and Error Handling', () {
    test('Zero handling', () {
      expect(0.toWords(), 'zero');
      expect(0.toVietnamese(), 'không');
      expect(0.toSpanish(), 'cero');
    });

    test('Very large numbers', () {
      final largeNumber = 999999999999999;
      expect(largeNumber.toWords().isNotEmpty, true);
      expect(largeNumber.canConvertToWords(), true);
    });

    test('Extension error handling', () {
      expect(
        () => 123.toWordsInLanguage('unsupported'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
