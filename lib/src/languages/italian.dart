import '../language_base.dart';

/// Italian language implementation for number to words conversion
class ItalianNumberToWords extends NumberToWordsLanguage {
  @override
  String get languageCode => 'it';

  @override
  String get languageName => 'Italian';

  @override
  String get minusWord => 'meno';

  @override
  String get pointWord => 'virgola';

  static const String _zero = 'zero';
  static const String _hundred = 'cento';

  static const List<String> _scaleNames = [
    '',
    'mila',
    'milioni',
    'miliardi',
    'bilioni',
  ];

  static const List<String> _numNames = [
    '',
    'uno',
    'due',
    'tre',
    'quattro',
    'cinque',
    'sei',
    'sette',
    'otto',
    'nove',
    'dieci',
    'undici',
    'dodici',
    'tredici',
    'quattordici',
    'quindici',
    'sedici',
    'diciassette',
    'diciotto',
    'diciannove'
  ];

  static const List<String> _tensNames = [
    '',
    'dieci',
    'venti',
    'trenta',
    'quaranta',
    'cinquanta',
    'sessanta',
    'settanta',
    'ottanta',
    'novanta'
  ];

  @override
  String convertLessThanOneThousand(int number) {
    if (number == 0) return '';

    String result = '';

    // Handle hundreds
    if (number >= 100) {
      int hundreds = number ~/ 100;
      if (hundreds == 1) {
        result = _hundred;
      } else {
        result = '${_numNames[hundreds]}$_hundred';
      }
      number %= 100;
    }

    // Handle tens and ones
    if (number >= 20) {
      int tens = number ~/ 10;
      int ones = number % 10;

      String tensWord = _tensNames[tens];

      // Italian specific rules for combining tens and ones
      if (ones == 1 || ones == 8) {
        // Remove final vowel before "uno" or "otto"
        if (tensWord.endsWith('i') || tensWord.endsWith('e')) {
          tensWord = tensWord.substring(0, tensWord.length - 1);
        }
      }

      if (ones > 0) {
        tensWord += _numNames[ones];
      }

      if (result.isNotEmpty) {
        result += tensWord;
      } else {
        result = tensWord;
      }
    } else if (number > 0) {
      if (result.isNotEmpty) {
        result += _numNames[number];
      } else {
        result = _numNames[number];
      }
    }

    return result;
  }

  @override
  String convertIntegerPart(int number) {
    if (number == 0) return _zero;

    if (number < 1000) {
      return convertLessThanOneThousand(number);
    }

    List<String> parts = [];
    int scaleIndex = 0;

    while (number > 0 && scaleIndex < _scaleNames.length) {
      int remainder = number % 1000;
      if (remainder > 0) {
        String part = convertLessThanOneThousand(remainder);
        if (scaleIndex > 0) {
          if (scaleIndex == 1) {
            // Thousands
            if (remainder == 1) {
              part = 'mille';
            } else {
              part += _scaleNames[scaleIndex];
            }
          } else {
            // Millions, billions, etc.
            if (remainder == 1) {
              String singular = scaleIndex == 2
                  ? 'milione'
                  : scaleIndex == 3
                      ? 'miliardo'
                      : 'bilione';
              part = 'un $singular';
            } else {
              part += ' ${_scaleNames[scaleIndex]}';
            }
          }
        }
        parts.insert(0, part);
      }
      number ~/= 1000;
      scaleIndex++;
    }

    return parts.join('');
  }

  @override
  String convertDecimal(String numberStr) {
    if (!isValidNumber(numberStr)) {
      throw ArgumentError('Input is not a valid number');
    }

    bool isNegative = numberStr.startsWith('-');
    if (isNegative) {
      numberStr = numberStr.substring(1);
    }

    List<String> parts = numberStr.split('.');
    String integerPartStr = parts[0];
    String decimalPartStr = parts.length > 1 ? parts[1] : '';

    int integerPart = int.parse(integerPartStr);
    String integerWords = convertIntegerPart(integerPart);

    if (decimalPartStr.isEmpty) {
      return (isNegative ? '$minusWord ' : '') + integerWords;
    }

    String decimalWords = pointWord;
    for (int i = 0; i < decimalPartStr.length; i++) {
      int digit = int.parse(decimalPartStr[i]);
      decimalWords += ' ${convertIntegerPart(digit)}';
    }

    String result = '$integerWords $decimalWords';
    result = result.replaceAll(RegExp('\\s+'), ' ').trim();
    if (isNegative) {
      result = '$minusWord $result';
    }
    return result;
  }

  @override
  String convert(num number) {
    bool isNegative = number < 0;
    if (number is int) {
      int absNumber = number.abs();
      String words = convertIntegerPart(absNumber);
      return isNegative ? '$minusWord $words' : words;
    } else {
      return convertDecimal(number.toString());
    }
  }

  // Currency data for Italian
  static const Map<String, Map<String, String>> _currencyData = {
    'USD': {
      'major': 'dollaro',
      'majorPlural': 'dollari',
      'minor': 'centesimo',
      'minorPlural': 'centesimi',
      'decimals': '2'
    },
    'EUR': {
      'major': 'euro',
      'majorPlural': 'euro',
      'minor': 'centesimo',
      'minorPlural': 'centesimi',
      'decimals': '2'
    },
    'GBP': {
      'major': 'sterlina',
      'majorPlural': 'sterline',
      'minor': 'penny',
      'minorPlural': 'pence',
      'decimals': '2'
    },
    'JPY': {
      'major': 'yen',
      'majorPlural': 'yen',
      'minor': '',
      'minorPlural': '',
      'decimals': '0'
    },
    'VND': {
      'major': 'dong',
      'majorPlural': 'dong',
      'minor': 'xu',
      'minorPlural': 'xu',
      'decimals': '2'
    },
    'CNY': {
      'major': 'yuan',
      'majorPlural': 'yuan',
      'minor': 'jiao',
      'minorPlural': 'jiao',
      'decimals': '2'
    },
    'KRW': {
      'major': 'won',
      'majorPlural': 'won',
      'minor': '',
      'minorPlural': '',
      'decimals': '0'
    },
    'THB': {
      'major': 'baht',
      'majorPlural': 'baht',
      'minor': 'satang',
      'minorPlural': 'satang',
      'decimals': '2'
    },
    'SGD': {
      'major': 'dollaro di Singapore',
      'majorPlural': 'dollari di Singapore',
      'minor': 'centesimo',
      'minorPlural': 'centesimi',
      'decimals': '2'
    },
    'AUD': {
      'major': 'dollaro australiano',
      'majorPlural': 'dollari australiani',
      'minor': 'centesimo',
      'minorPlural': 'centesimi',
      'decimals': '2'
    },
    'CAD': {
      'major': 'dollaro canadese',
      'majorPlural': 'dollari canadesi',
      'minor': 'centesimo',
      'minorPlural': 'centesimi',
      'decimals': '2'
    },
    'CHF': {
      'major': 'franco svizzero',
      'majorPlural': 'franchi svizzeri',
      'minor': 'centesimo',
      'minorPlural': 'centesimi',
      'decimals': '2'
    },
  };

  @override
  String convertCurrency(double amount, String currencyCode) {
    if (amount < 0) {
      throw ArgumentError('Currency amounts cannot be negative');
    }

    final currency = _currencyData[currencyCode.toUpperCase()];
    if (currency == null) {
      throw ArgumentError('Currency code "$currencyCode" is not supported. '
          'Supported currencies: ${_currencyData.keys.join(', ')}');
    }

    final decimals = int.parse(currency['decimals']!);

    // Split into major and minor units
    final majorAmount = amount.floor();
    final minorAmount = decimals > 0
        ? ((amount - majorAmount) * (decimals == 2 ? 100 : 10)).round()
        : 0;

    // Convert major amount
    String majorWords = convertIntegerPart(majorAmount);
    String majorUnit =
        majorAmount == 1 ? currency['major']! : currency['majorPlural']!;
    String result = '$majorWords $majorUnit';

    // Add minor amount if applicable
    if (decimals > 0 && minorAmount > 0) {
      String minorWords = convertIntegerPart(minorAmount);
      String minorUnit =
          minorAmount == 1 ? currency['minor']! : currency['minorPlural']!;
      result += ' e $minorWords $minorUnit'; // "e" = "and" in Italian
    }

    return result;
  }

  @override
  String convertOrdinal(int number) {
    if (number <= 0) {
      throw ArgumentError('Ordinal numbers must be positive integers');
    }

    switch (number) {
      case 1:
        return 'primo';
      case 2:
        return 'secondo';
      case 3:
        return 'terzo';
      case 4:
        return 'quarto';
      case 5:
        return 'quinto';
      case 6:
        return 'sesto';
      case 7:
        return 'settimo';
      case 8:
        return 'ottavo';
      case 9:
        return 'nono';
      case 10:
        return 'decimo';
      default:
        // For larger numbers, use cardinal + º
        String baseWords = convertIntegerPart(number);
        return '${baseWords}º';
    }
  }
}
