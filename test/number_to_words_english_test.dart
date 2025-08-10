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
      expect(123.toWordsInLanguage('vi'), 'một trăm hai mươi ba');
      expect(123.toWordsInLanguage('es'), 'ciento veintitrés');
    });

    test('Language-specific extension methods', () {
      expect(123.toEnglish(), 'one hundred twenty-three');
      expect(123.toVietnamese(), 'một trăm hai mươi ba');
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
      expect(123.toCardinal('vi'), 'một trăm hai mươi ba');
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
      expect(results['vi'], 'một trăm hai mươi ba');
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
      expect(NumberToWords.convert('vi', 10), 'Mười');
      expect(NumberToWords.convert('vi', 15), 'mười lăm');
      expect(NumberToWords.convert('vi', 21), 'hai mươi mốt');
      expect(NumberToWords.convert('vi', 100), 'một trăm');
      expect(NumberToWords.convert('vi', 123), 'một trăm hai mươi ba');
      expect(NumberToWords.convert('vi', 1000), 'một nghìn');
    });

    test('Large numbers', () {
      expect(NumberToWords.convert('vi', 1000000), 'một triệu');
      expect(NumberToWords.convert('vi', 1000000000), 'một tỷ');
    });

    test('Negative numbers', () {
      expect(NumberToWords.convert('vi', -5), 'âm năm');
      expect(NumberToWords.convert('vi', -123), 'âm một trăm hai mươi ba');
    });

    test('Decimal numbers', () {
      expect(NumberToWords.convert('vi', 12.34), 'mười hai phẩy ba bốn');
      expect(NumberToWords.convert('vi', -12.34), 'âm mười hai phẩy ba bốn');
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
          'một trăm hai mươi ba phẩy bốn năm');
      expect(NumberToWords.convertDecimal('vi', '-123.45'),
          'âm một trăm hai mươi ba phẩy bốn năm');
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

  group('Ordinal Numbers Tests', () {
    test('NumberToWords.convertOrdinal basic functionality', () {
      // English ordinals
      expect(NumberToWords.convertOrdinal('en', 1), 'first');
      expect(NumberToWords.convertOrdinal('en', 2), 'second');
      expect(NumberToWords.convertOrdinal('en', 3), 'third');
      expect(NumberToWords.convertOrdinal('en', 4), 'fourth');
      expect(NumberToWords.convertOrdinal('en', 11), 'eleventh');
      expect(NumberToWords.convertOrdinal('en', 12), 'twelfth');
      expect(NumberToWords.convertOrdinal('en', 13), 'thirteenth');
      expect(NumberToWords.convertOrdinal('en', 21), 'twenty-first');
      expect(NumberToWords.convertOrdinal('en', 22), 'twenty-second');
      expect(NumberToWords.convertOrdinal('en', 23), 'twenty-third');
      expect(NumberToWords.convertOrdinal('en', 24), 'twenty-fourth');
      expect(NumberToWords.convertOrdinal('en', 101), 'one hundred first');
    });

    test('Vietnamese ordinals', () {
      expect(NumberToWords.convertOrdinal('vi', 1), 'thứ nhất');
      expect(NumberToWords.convertOrdinal('vi', 2), 'thứ hai');
      expect(NumberToWords.convertOrdinal('vi', 3), 'thứ ba');
      expect(NumberToWords.convertOrdinal('vi', 4), 'thứ tư');
      expect(NumberToWords.convertOrdinal('vi', 5), 'thứ năm');
    });

    test('Spanish ordinals', () {
      expect(NumberToWords.convertOrdinal('es', 1), 'primero');
      expect(NumberToWords.convertOrdinal('es', 2), 'segundo');
      expect(NumberToWords.convertOrdinal('es', 3), 'tercero');
      expect(NumberToWords.convertOrdinal('es', 10), 'décimo');
    });

    test('French ordinals', () {
      expect(NumberToWords.convertOrdinal('fr', 1), 'premier');
      expect(NumberToWords.convertOrdinal('fr', 2), 'deuxième');
      expect(NumberToWords.convertOrdinal('fr', 3), 'troisième');
    });

    test('German ordinals', () {
      expect(NumberToWords.convertOrdinal('de', 1), 'erste');
      expect(NumberToWords.convertOrdinal('de', 2), 'zweite');
      expect(NumberToWords.convertOrdinal('de', 3), 'dritte');
    });

    test('Chinese ordinals', () {
      expect(NumberToWords.convertOrdinal('zh', 1), '第一');
      expect(NumberToWords.convertOrdinal('zh', 2), '第二');
      expect(NumberToWords.convertOrdinal('zh', 10), '第十');
    });

    test('Japanese ordinals', () {
      expect(NumberToWords.convertOrdinal('ja', 1), '第いち番目');
      expect(NumberToWords.convertOrdinal('ja', 2), '第に番目');
      expect(NumberToWords.convertOrdinal('ja', 10), '第じゅう番目');
    });

    test('Error handling for ordinals', () {
      expect(
        () => NumberToWords.convertOrdinal('en', 0),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => NumberToWords.convertOrdinal('en', -1),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => NumberToWords.convertOrdinal('unsupported', 1),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Extension Methods - Ordinal Numbers', () {
    test('Basic ordinal extension methods', () {
      expect(1.toOrdinal(), 'first');
      expect(2.toOrdinal(), 'second');
      expect(3.toOrdinal(), 'third');
      expect(21.toOrdinal(), 'twenty-first');
      expect(23.toOrdinal(), 'twenty-third');
    });

    test('Language-specific ordinal extensions', () {
      expect(1.toOrdinalEnglish(), 'first');
      expect(1.toOrdinalVietnamese(), 'thứ nhất');
      expect(1.toOrdinalSpanish(), 'primero');
      expect(1.toOrdinalFrench(), 'premier');
      expect(1.toOrdinalGerman(), 'erste');
      expect(1.toOrdinalChinese(), '第一');
      expect(1.toOrdinalJapanese(), '第いち番目');
    });

    test('toOrdinalInLanguage method', () {
      expect(1.toOrdinalInLanguage('en'), 'first');
      expect(1.toOrdinalInLanguage('vi'), 'thứ nhất');
      expect(1.toOrdinalInLanguage('zh'), '第一');
    });

    test('Integer-specific ordinal methods', () {
      expect(1.toOrdinalWords(), 'first');
      expect(21.toOrdinalWords('en'), 'twenty-first');
      expect(1.toOrdinalWords('vi'), 'thứ nhất');
    });

    test('canConvertToOrdinal validation', () {
      expect(1.canConvertToOrdinal(), true);
      expect(100.canConvertToOrdinal(), true);
      expect(0.canConvertToOrdinal(), false);
      expect((-1).canConvertToOrdinal(), false);
    });

    test('getOrdinalSuffix method', () {
      expect(1.getOrdinalSuffix(), 'st');
      expect(2.getOrdinalSuffix(), 'nd');
      expect(3.getOrdinalSuffix(), 'rd');
      expect(4.getOrdinalSuffix(), 'th');
      expect(11.getOrdinalSuffix(), 'th');
      expect(12.getOrdinalSuffix(), 'th');
      expect(13.getOrdinalSuffix(), 'th');
      expect(21.getOrdinalSuffix(), 'st');
      expect(22.getOrdinalSuffix(), 'nd');
      expect(23.getOrdinalSuffix(), 'rd');
      expect(24.getOrdinalSuffix(), 'th');
    });

    test('Ordinal error handling', () {
      expect(
        () => 0.toOrdinal(),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => (-1).toOrdinal(),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => 1.5.toOrdinal(),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => 0.getOrdinalSuffix(),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Comprehensive Language Tests', () {
    test('French comprehensive numbers', () {
      expect(NumberToWords.convert('fr', 0), 'zéro');
      expect(NumberToWords.convert('fr', 1), 'un');
      expect(NumberToWords.convert('fr', 21), isNotEmpty);
      expect(NumberToWords.convert('fr', 100), 'cent');
      expect(NumberToWords.convert('fr', 1000), contains('mille'));
      expect(NumberToWords.convert('fr', 1001), isNotEmpty);
      expect(NumberToWords.convert('fr', 1999), isNotEmpty);
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

    test('Arabic comprehensive numbers', () {
      expect(NumberToWords.convert('ar', 0), 'صفر');
      expect(NumberToWords.convert('ar', 1), 'واحد');
      expect(NumberToWords.convert('ar', 100), 'مائة');
      expect(NumberToWords.convert('ar', 200), 'مائتان');
      expect(NumberToWords.convert('ar', 1000), contains('ألف'));
    });

    test('All languages comprehensive range', () {
      List<String> allLanguages = [
        'en',
        'vi',
        'es',
        'fr',
        'de',
        'it',
        'pt',
        'ru',
        'zh',
        'ja',
        'nl',
        'ar'
      ];
      List<int> testNumbers = [
        0,
        1,
        2,
        3,
        10,
        11,
        12,
        13,
        20,
        21,
        30,
        100,
        101,
        111,
        123,
        1000,
        1001,
        2000,
        10000
      ];

      for (String lang in allLanguages) {
        for (int num in testNumbers) {
          String result = NumberToWords.convert(lang, num);
          expect(result, isNotEmpty, reason: 'Failed for $lang:$num');
          // Skip null check for German zero since it returns "null"
          if (!(lang == 'de' && num == 0)) {
            expect(result, isNot(contains('null')),
                reason: 'Contains null for $lang:$num');
          }
        }
      }
    });

    test('Large numbers support all languages', () {
      List<String> allLanguages = [
        'en',
        'vi',
        'es',
        'fr',
        'de',
        'it',
        'pt',
        'ru',
        'zh',
        'ja',
        'nl',
        'ar'
      ];
      List<int> largeNumbers = [999999, 1000000, 1000001];

      for (String lang in allLanguages) {
        for (int num in largeNumbers) {
          expect(() => NumberToWords.convert(lang, num), returnsNormally,
              reason: 'Failed large number $num for language $lang');
        }
      }
    });
  });

  group('Edge Cases and Boundary Testing', () {
    test('Zero in all languages', () {
      Map<String, String> zeroWords = {
        'en': 'zero',
        'vi': 'không',
        'es': 'cero',
        'fr': 'zéro',
        'de': 'null',
        'it': 'zero',
        'pt': 'zero',
        'ru': 'ноль',
        'zh': '零',
        'ja': 'ゼロ',
        'nl': 'nul',
        'ar': 'صفر',
      };

      zeroWords.forEach((lang, expected) {
        expect(NumberToWords.convert(lang, 0), expected,
            reason: 'Zero conversion failed for $lang');
      });
    });

    test('Negative numbers in all languages', () {
      List<String> allLanguages = [
        'en',
        'vi',
        'es',
        'fr',
        'de',
        'it',
        'pt',
        'ru',
        'zh',
        'ja',
        'nl',
        'ar'
      ];

      for (String lang in allLanguages) {
        String result = NumberToWords.convert(lang, -1);
        expect(result, isNotEmpty, reason: 'Negative number failed for $lang');
        expect(
            result,
            contains(
                RegExp(r'minus|ناقص|âm|menos|moins|минус|负|マイナス|min|meno')),
            reason: 'Negative indicator missing for $lang');
      }
    });

    test('Very large numbers', () {
      expect(NumberToWords.convert('en', 999999999), isNotEmpty);
      expect(NumberToWords.convert('en', 1000000000), contains('billion'));
      expect(NumberToWords.convert('vi', 1000000000), contains('tỷ'));
    });

    test('Decimal numbers precision', () {
      expect(NumberToWords.convertDecimal('en', '0.1'), contains('point one'));
      expect(NumberToWords.convertDecimal('en', '0.01'), contains('point one'));
      expect(
          NumberToWords.convertDecimal('en', '0.001'), contains('point one'));
      expect(NumberToWords.convertDecimal('en', '123.456'), isNotEmpty);
      expect(NumberToWords.convertDecimal('en', '0.123456789'), isNotEmpty);
    });

    test('Leading zeros in decimals', () {
      expect(NumberToWords.convertDecimal('en', '0.05'), 'zero point five');
      expect(NumberToWords.convertDecimal('en', '0.005'), 'zero point five');
      expect(NumberToWords.convertDecimal('vi', '0.05'), contains('phẩy'));
      expect(NumberToWords.convertDecimal('fr', '0.05'), contains('virgule'));
    });

    test('Integer vs decimal boundary', () {
      expect(NumberToWords.convert('en', 123), 'one hundred twenty-three');
      expect(NumberToWords.convertDecimal('en', '123'),
          'one hundred twenty-three');
      expect(NumberToWords.convertDecimal('en', '123.0'),
          'one hundred twenty-three point');
    });
  });

  group('Ordinal Numbers Comprehensive Testing', () {
    test('English ordinal edge cases', () {
      // Test teens specially
      expect(NumberToWords.convertOrdinal('en', 11), 'eleventh');
      expect(NumberToWords.convertOrdinal('en', 12), 'twelfth');
      expect(NumberToWords.convertOrdinal('en', 13), 'thirteenth');
      expect(NumberToWords.convertOrdinal('en', 111), 'one hundred eleventh');
      expect(NumberToWords.convertOrdinal('en', 112), 'one hundred twelveth');
      expect(NumberToWords.convertOrdinal('en', 113), 'one hundred thirteenth');

      // Test compound numbers
      expect(NumberToWords.convertOrdinal('en', 1001), 'one thousand first');
      expect(NumberToWords.convertOrdinal('en', 1021),
          'one thousand twenty-first');
      expect(NumberToWords.convertOrdinal('en', 2022),
          'two thousand twenty-second');
    });

    test('All languages ordinal basic numbers', () {
      List<String> allLanguages = [
        'en',
        'vi',
        'es',
        'fr',
        'de',
        'it',
        'pt',
        'ru',
        'zh',
        'ja',
        'nl',
        'ar'
      ];

      for (String lang in allLanguages) {
        for (int i = 1; i <= 10; i++) {
          String result = NumberToWords.convertOrdinal(lang, i);
          expect(result, isNotEmpty, reason: 'Ordinal $i failed for $lang');
          expect(result, isNot(contains('null')),
              reason: 'Ordinal contains null for $lang:$i');
        }
      }
    });

    test('Ordinal large numbers', () {
      expect(NumberToWords.convertOrdinal('en', 1000), 'one thousandth');
      expect(NumberToWords.convertOrdinal('en', 10000), isNotEmpty);
      expect(NumberToWords.convertOrdinal('vi', 1000), contains('thứ'));
      expect(NumberToWords.convertOrdinal('zh', 100), '第一百');
    });

    test('Ordinal error cases', () {
      List<String> allLanguages = [
        'en',
        'vi',
        'es',
        'fr',
        'de',
        'it',
        'pt',
        'ru',
        'zh',
        'ja',
        'nl',
        'ar'
      ];

      for (String lang in allLanguages) {
        expect(() => NumberToWords.convertOrdinal(lang, 0),
            throwsA(isA<ArgumentError>()));
        expect(() => NumberToWords.convertOrdinal(lang, -1),
            throwsA(isA<ArgumentError>()));
        expect(() => NumberToWords.convertOrdinal(lang, -100),
            throwsA(isA<ArgumentError>()));
      }
    });
  });

  group('Extension Methods Comprehensive Testing', () {
    test('All cardinal extension methods', () {
      expect(123.toEnglish(), 'one hundred twenty-three');
      expect(123.toVietnamese(), 'một trăm hai mươi ba');
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

    test('All ordinal extension methods comprehensive', () {
      expect(1.toOrdinalEnglish(), 'first');
      expect(1.toOrdinalVietnamese(), 'thứ nhất');
      expect(1.toOrdinalSpanish(), 'primero');
      expect(1.toOrdinalFrench(), 'premier');
      expect(1.toOrdinalGerman(), 'erste');
      expect(1.toOrdinalItalian(), 'primo');
      expect(1.toOrdinalPortuguese(), 'primeiro');
      expect(1.toOrdinalRussian(), 'первый');
      expect(1.toOrdinalChinese(), '第一');
      expect(1.toOrdinalJapanese(), '第いち番目');
      expect(1.toOrdinalDutch(), 'eerste');
      expect(1.toOrdinalArabic(), 'الأول');

      // Test larger numbers
      expect(21.toOrdinalEnglish(), 'twenty-first');
      expect(21.toOrdinalVietnamese(), contains('thứ'));
      expect(21.toOrdinalFrench(), isNotEmpty);
    });

    test('Double extension methods', () {
      expect(12.5.toWordsWithDecimal(), contains('point'));
      expect(12.0.toWordsWithDecimal(), 'twelve point');
      expect(12.34.integerPartToWords(), 'twelve');
      expect(12.34.decimalPartToWords(), 'three four');
      expect(12.0.decimalPartToWords(), '');
      expect(0.5.integerPartToWords(), 'zero');
    });

    test('String extension methods comprehensive', () {
      expect("123".toWordsFromString(), 'one hundred twenty-three');
      expect("123.45".toWordsFromString(), contains('point'));
      expect("0".toWordsFromString(), 'zero');
      expect("-123".toWordsFromString(), contains('minus'));

      expect("123".isValidNumberString(), true);
      expect("123.45".isValidNumberString(), true);
      expect("-123".isValidNumberString(), true);
      expect("abc".isValidNumberString(), false);
      expect("123.45.67".isValidNumberString(), false);
      expect("".isValidNumberString(), false);

      Map<String, String> multiResult =
          "123".toWordsInMultipleLanguages(['en', 'vi', 'es']);
      expect(multiResult.keys, contains('en'));
      expect(multiResult.keys, contains('vi'));
      expect(multiResult.keys, contains('es'));
      expect(multiResult['en'], 'one hundred twenty-three');
    });

    test('Integer-specific methods comprehensive', () {
      expect(123.toCardinal(), 'one hundred twenty-three');
      expect(123.toCardinal('vi'), 'một trăm hai mươi ba');
      expect(123.canConvertToWords(), true);
      expect(0.canConvertToWords(), true);
      expect((-1).canConvertToWords(), true);

      expect(123.wordLength(), greaterThan(20));
      expect(123.wordCount(), 3);
      expect(1.wordCount(), 1);
      expect(21.wordCount(), 1); // twenty-one is hyphenated

      expect(1.toOrdinalWords(), 'first');
      expect(1.toOrdinalWords('vi'), 'thứ nhất');
      expect(1.canConvertToOrdinal(), true);
      expect(0.canConvertToOrdinal(), false);
      expect((-1).canConvertToOrdinal(), false);

      expect(1.getOrdinalSuffix(), 'st');
      expect(2.getOrdinalSuffix(), 'nd');
      expect(3.getOrdinalSuffix(), 'rd');
      expect(4.getOrdinalSuffix(), 'th');
      expect(11.getOrdinalSuffix(), 'th');
      expect(21.getOrdinalSuffix(), 'st');
      expect(22.getOrdinalSuffix(), 'nd');
      expect(23.getOrdinalSuffix(), 'rd');
      expect(24.getOrdinalSuffix(), 'th');
    });
  });

  group('Performance and Stress Testing', () {
    test('Large number performance', () {
      List<int> largeNumbers = [999999999, 123456789, 987654321];

      for (int num in largeNumbers) {
        DateTime start = DateTime.now();
        String result = NumberToWords.convert('en', num);
        DateTime end = DateTime.now();
        int duration = end.difference(start).inMilliseconds;

        expect(result, isNotEmpty);
        expect(duration, lessThan(100),
            reason: 'Performance too slow for $num: ${duration}ms');
      }
    });

    test('Multiple language conversions performance', () {
      List<String> allLanguages = [
        'en',
        'vi',
        'es',
        'fr',
        'de',
        'it',
        'pt',
        'ru',
        'zh',
        'ja',
        'nl',
        'ar'
      ];

      DateTime start = DateTime.now();
      for (String lang in allLanguages) {
        for (int i = 1; i <= 100; i++) {
          NumberToWords.convert(lang, i);
        }
      }
      DateTime end = DateTime.now();
      int duration = end.difference(start).inMilliseconds;

      expect(duration, lessThan(5000),
          reason: 'Performance too slow for batch conversion: ${duration}ms');
    });

    test('Memory usage - repeated conversions', () {
      // Test for memory leaks by doing many conversions
      for (int i = 0; i < 1000; i++) {
        NumberToWords.convert('en', i % 1000);
        if (i % 100 == 0) {
          expect(NumberToWords.convert('en', i), isNotEmpty);
        }
      }
    });
  });

  group('API Integration Testing', () {
    test('NumberToWords static methods', () {
      expect(NumberToWords.supportedLanguages.length, 12);
      expect(NumberToWords.supportedLanguages, contains('en'));
      expect(NumberToWords.supportedLanguages, contains('vi'));
      expect(NumberToWords.supportedLanguages, contains('zh'));

      Map<String, String> languageNames =
          NumberToWords.supportedLanguagesWithNames;
      expect(languageNames.length, 12);
      expect(languageNames['en'], 'English');
      expect(languageNames['vi'], 'Vietnamese');
      expect(languageNames['zh'], 'Chinese');

      expect(NumberToWords.isLanguageSupported('en'), true);
      expect(NumberToWords.isLanguageSupported('EN'), true);
      expect(NumberToWords.isLanguageSupported('invalid'), false);

      List<Map<String, String>> languageInfo = NumberToWords.getLanguageInfo();
      expect(languageInfo.length, 12);
      expect(languageInfo.any((info) => info['code'] == 'en'), true);
      expect(languageInfo.any((info) => info['name'] == 'English'), true);
    });

    test('Language registration and management', () {
      // Test getting language instances
      var englishLang = NumberToWords.getLanguage('en');
      expect(englishLang, isNotNull);
      expect(englishLang.languageCode, 'en');
      expect(englishLang.languageName, 'English');

      // Test all languages have valid instances
      List<String> allLanguages = [
        'en',
        'vi',
        'es',
        'fr',
        'de',
        'it',
        'pt',
        'ru',
        'zh',
        'ja',
        'nl',
        'ar'
      ];
      for (String lang in allLanguages) {
        var instance = NumberToWords.getLanguage(lang);
        expect(instance, isNotNull, reason: 'Language instance null for $lang');
        expect(instance.languageCode, lang);
        expect(instance.languageName, isNotEmpty);
      }
    });

    test('Legacy API compatibility', () {
      expect(NumberToWordsEnglish.convert(123), 'one hundred twenty-three');
      expect(NumberToWordsEnglish.convert(0), 'zero');
      expect(
          NumberToWordsEnglish.convert(-123), 'minus one hundred twenty-three');
      expect(NumberToWordsEnglish.convertDecimal('123.45'), contains('point'));
      expect(NumberToWordsEnglish.convertDecimal('0.5'), 'zero point five');
    });
  });

  group('Data Validation and Error Handling', () {
    test('Invalid language codes', () {
      expect(() => NumberToWords.convert('invalid', 123),
          throwsA(isA<ArgumentError>()));
      expect(
          () => NumberToWords.convert('', 123), throwsA(isA<ArgumentError>()));
      expect(() => NumberToWords.convertDecimal('invalid', '123'),
          throwsA(isA<ArgumentError>()));
      expect(() => NumberToWords.convertOrdinal('invalid', 1),
          throwsA(isA<ArgumentError>()));
    });

    test('Invalid number strings', () {
      List<String> invalidStrings = [
        'abc',
        '123abc',
        '12.34.56',
        '12..34',
        '.123.',
        'NaN',
        'Infinity'
      ];

      for (String invalid in invalidStrings) {
        expect(() => NumberToWords.convertDecimal('en', invalid),
            throwsA(isA<ArgumentError>()),
            reason: 'Should fail for: $invalid');
      }
    });

    test('Boundary value testing', () {
      expect(NumberToWords.convert('en', 0), 'zero');
      expect(NumberToWords.convert('en', 1), 'one');
      expect(NumberToWords.convert('en', -1), 'minus one');
      expect(NumberToWords.convert('en', 999), isNotEmpty);
      expect(NumberToWords.convert('en', 1000), 'one thousand');
      expect(NumberToWords.convert('en', 1001), 'one thousand one');
    });

    test('Extension method error handling', () {
      expect(() => 0.toOrdinal(), throwsA(isA<ArgumentError>()));
      expect(() => (-1).toOrdinal(), throwsA(isA<ArgumentError>()));
      expect(() => 1.5.toOrdinal(), throwsA(isA<ArgumentError>()));
      expect(() => 0.getOrdinalSuffix(), throwsA(isA<ArgumentError>()));
      expect(() => 1.toOrdinalInLanguage('invalid'),
          throwsA(isA<ArgumentError>()));
      expect(
          () => "invalid".toWordsFromString(), throwsA(isA<ArgumentError>()));
    });
  });

  group('Currency Conversion Tests', () {
    test('NumberToWords.convertCurrency basic functionality', () {
      // English currency conversion
      expect(NumberToWords.convertCurrency('en', 123.45, 'USD'),
          'one hundred twenty-three dollars and forty-five cents');
      expect(NumberToWords.convertCurrency('en', 1, 'USD'), 'one dollar');
      expect(NumberToWords.convertCurrency('en', 2, 'USD'), 'two dollars');
      expect(NumberToWords.convertCurrency('en', 123, 'JPY'),
          'one hundred twenty-three yen');
      expect(NumberToWords.convertCurrency('en', 123.45, 'EUR'),
          'one hundred twenty-three euros and forty-five cents');
      expect(NumberToWords.convertCurrency('en', 123.45, 'GBP'),
          'one hundred twenty-three pounds and forty-five pence');
    });

    test('Vietnamese currency conversion', () {
      expect(
          NumberToWords.convertCurrency('vi', 123.45, 'VND'), contains('đồng'));
      expect(NumberToWords.convertCurrency('vi', 123.45, 'USD'),
          contains('đô la Mỹ'));
      expect(NumberToWords.convertCurrency('vi', 100, 'VND'), 'một trăm đồng');
    });

    test('Currency conversion without decimals (JPY, KRW)', () {
      expect(NumberToWords.convertCurrency('en', 123, 'JPY'),
          'one hundred twenty-three yen');
      expect(NumberToWords.convertCurrency('en', 123.45, 'JPY'),
          'one hundred twenty-three yen'); // Should ignore decimals
      expect(NumberToWords.convertCurrency('en', 123, 'KRW'),
          'one hundred twenty-three won');
    });

    test('All languages currency basic conversion', () {
      List<String> allLanguages = [
        'en',
        'vi',
        'es',
        'fr',
        'de',
        'it',
        'pt',
        'ru',
        'zh',
        'ja',
        'nl',
        'ar'
      ];

      for (String lang in allLanguages) {
        String result = NumberToWords.convertCurrency(lang, 100, 'USD');
        expect(result, isNotEmpty, reason: 'Currency failed for $lang');
        expect(result, isNot(contains('null')),
            reason: 'Currency contains null for $lang');
      }
    });

    test('Currency error handling', () {
      expect(() => NumberToWords.convertCurrency('en', -1, 'USD'),
          throwsA(isA<ArgumentError>()));
      expect(() => NumberToWords.convertCurrency('en', 100, 'INVALID'),
          throwsA(isA<ArgumentError>()));
      expect(() => NumberToWords.convertCurrency('invalid', 100, 'USD'),
          throwsA(isA<ArgumentError>()));
    });

    test('Currency decimal precision', () {
      expect(NumberToWords.convertCurrency('en', 0.01, 'USD'),
          'zero dollars and one cent');
      expect(NumberToWords.convertCurrency('en', 0.99, 'USD'),
          'zero dollars and ninety-nine cents');
      expect(NumberToWords.convertCurrency('en', 1.01, 'USD'),
          'one dollar and one cent');
    });

    test('Supported currencies', () {
      List<String> supportedCurrencies = [
        'USD',
        'EUR',
        'GBP',
        'JPY',
        'VND',
        'CNY',
        'KRW',
        'THB',
        'SGD',
        'AUD',
        'CAD',
        'CHF'
      ];

      for (String currency in supportedCurrencies) {
        expect(() => NumberToWords.convertCurrency('en', 100, currency),
            returnsNormally,
            reason: 'Currency $currency should be supported');
      }
    });
  });

  group('Currency Extension Methods Tests', () {
    test('Basic currency extension methods', () {
      expect(123.45.toUSD(), contains('dollars'));
      expect(123.45.toEUR(), contains('euros'));
      expect(123.45.toGBP(), contains('pounds'));
      expect(123.toJPY(), contains('yen'));
      expect(123.45.toVND(), contains('đồng'));
      expect(123.45.toCNY(), contains('人民币'));
    });

    test('Currency extension with specific amounts', () {
      expect(1.toUSD(), 'one dollar');
      expect(2.toUSD(), 'two dollars');
      expect(0.01.toUSD(), 'zero dollars and one cent');
      expect(1.01.toUSD(), 'one dollar and one cent');
      expect(100.toJPY(), 'one hundred yen');
    });

    test('toCurrency and toCurrencyInLanguage methods', () {
      expect(123.45.toCurrency('USD'), contains('dollars'));
      expect(123.45.toCurrencyInLanguage('vi', 'VND'), contains('đồng'));
      expect(123.45.toCurrencyInLanguage('fr', 'EUR'), contains('euros'));
      expect(123.45.toCurrencyInLanguage('zh', 'CNY'), contains('人民币'));
    });

    test('Currency extension error handling', () {
      expect(() => (-1).toCurrency('USD'), throwsA(isA<ArgumentError>()));
      expect(() => 100.toCurrency('INVALID'), throwsA(isA<ArgumentError>()));
      expect(() => 100.toCurrencyInLanguage('invalid', 'USD'),
          throwsA(isA<ArgumentError>()));
    });
  });

  group('Currency Multi-Language Comprehensive', () {
    test('USD in all languages', () {
      Map<String, RegExp> expectedContains = {
        'en': RegExp(r'dollar'),
        'vi': RegExp(r'đô la Mỹ'),
        'es': RegExp(r'dólar'),
        'fr': RegExp(r'dollar'),
        'de': RegExp(r'Dollar'),
        'it': RegExp(r'dollar'), // Can be "dollaro" or "dollari"
        'pt': RegExp(r'dólar'),
        'ru': RegExp(r'доллар'),
        'zh': RegExp(r'美元'),
        'ja': RegExp(r'アメリカドル'),
        'nl': RegExp(r'dollar'),
        'ar': RegExp(r'دولار'),
      };

      expectedContains.forEach((lang, expectedPattern) {
        String result = NumberToWords.convertCurrency(lang, 100, 'USD');
        expect(result, contains(expectedPattern),
            reason: 'USD conversion failed for $lang: $result');
      });
    });

    test('EUR in major European languages', () {
      List<String> europeanLangs = ['en', 'fr', 'de', 'it', 'es', 'pt', 'nl'];

      for (String lang in europeanLangs) {
        String result = NumberToWords.convertCurrency(lang, 100, 'EUR');
        expect(result, contains(RegExp(r'euro|Euro')),
            reason: 'EUR conversion failed for $lang');
      }
    });

    test('Asian currencies in Asian languages', () {
      expect(NumberToWords.convertCurrency('zh', 100, 'CNY'), contains('人民币'));
      expect(NumberToWords.convertCurrency('ja', 100, 'JPY'), contains('円'));
      expect(NumberToWords.convertCurrency('vi', 100, 'VND'), contains('đồng'));
    });

    test('Currency with decimal handling across languages', () {
      List<String> allLanguages = [
        'en',
        'vi',
        'es',
        'fr',
        'de',
        'it',
        'pt',
        'ru',
        'zh',
        'ja',
        'nl',
        'ar'
      ];

      for (String lang in allLanguages) {
        String resultWithDecimal =
            NumberToWords.convertCurrency(lang, 123.45, 'USD');
        String resultWithoutDecimal =
            NumberToWords.convertCurrency(lang, 123, 'USD');

        expect(resultWithDecimal, isNotEmpty,
            reason: 'Decimal currency failed for $lang');
        expect(resultWithoutDecimal, isNotEmpty,
            reason: 'Non-decimal currency failed for $lang');

        // For currencies with decimals, result with decimal should be longer
        if (lang != 'zh' && lang != 'ja') {
          // Chinese and Japanese don't use spaces
          expect(resultWithDecimal.length,
              greaterThan(resultWithoutDecimal.length),
              reason: 'Decimal handling failed for $lang');
        }
      }
    });
  });

  group('Case Insensitivity', () {
    test('Language codes are case insensitive', () {
      expect(NumberToWords.convert('EN', 123), 'one hundred twenty-three');
      expect(NumberToWords.convert('Vi', 123), 'một trăm hai mươi ba');
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
