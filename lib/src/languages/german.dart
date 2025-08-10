import '../language_base.dart';

/// German language implementation for number to words conversion
class GermanNumberToWords extends NumberToWordsLanguage {
  @override
  String get languageCode => 'de';

  @override
  String get languageName => 'German';

  @override
  String get minusWord => 'minus';

  @override
  String get pointWord => 'komma';

  static const String _zero = 'null';
  static const String _hundred = 'hundert';
  static const String _thousand = 'tausend';

  static const List<String> _scaleNames = [
    '',
    _thousand,
    'Million',
    'Milliarde',
    'Billion',
  ];

  static const List<String> _numNames = [
    '',
    'eins',
    'zwei',
    'drei',
    'vier',
    'fünf',
    'sechs',
    'sieben',
    'acht',
    'neun',
    'zehn',
    'elf',
    'zwölf',
    'dreizehn',
    'vierzehn',
    'fünfzehn',
    'sechzehn',
    'siebzehn',
    'achtzehn',
    'neunzehn'
  ];

  static const List<String> _tensNames = [
    '',
    'zehn',
    'zwanzig',
    'dreißig',
    'vierzig',
    'fünfzig',
    'sechzig',
    'siebzig',
    'achtzig',
    'neunzig'
  ];

  @override
  String convertLessThanOneThousand(int number) {
    if (number == 0) return '';

    String result = '';

    // Handle hundreds
    if (number >= 100) {
      int hundreds = number ~/ 100;
      result = (hundreds == 1) ? 'ein' : _numNames[hundreds];
      result += _hundred;
      number %= 100;
    }

    // Handle tens and ones
    if (number > 0) {
      if (number < 20) {
        String onesWord =
            (number == 1 && result.isNotEmpty) ? 'eins' : _numNames[number];
        result += onesWord;
      } else {
        int tens = number ~/ 10;
        int ones = number % 10;
        String tensStr = _tensNames[tens];
        if (ones > 0) {
          String onesStr = (ones == 1) ? 'ein' : _numNames[ones];
          result += '${onesStr}und$tensStr';
        } else {
          result += tensStr;
        }
      }
    }

    return result;
  }

  // Helper to determine if a number is part of a larger structure
  // This is a simplified check. A more robust solution might need more context.
  bool numberIsPartOfLargerNumber(int number) {
    // This is a placeholder. In a real scenario, you might pass a context flag.
    // For now, assume it's part of a larger number if it's being processed here.
    return true;
  }

  @override
  String convertIntegerPart(int number) {
    if (number == 0) return _zero;
    if (number == 1) return 'eins';

    if (number < 1000) {
      return convertLessThanOneThousand(number);
    }

    List<String> parts = [];
    int scaleIndex = 0;

    while (number > 0 && scaleIndex < _scaleNames.length) {
      int remainder = number % 1000;
      if (remainder > 0) {
        String part;
        if (scaleIndex == 1 && remainder == 1) {
          part = 'ein'; // eintausend
        } else {
          part = convertLessThanOneThousand(remainder);
        }

        if (scaleIndex > 0) {
          String scaleName = _scaleNames[scaleIndex];
          if (scaleIndex >= 2) {
            if (remainder == 1) {
              part = 'eine $scaleName';
            } else {
              part += ' ${scaleName}en';
            }
          } else {
            part += scaleName;
          }
        }
        parts.insert(0, part);
      }
      number ~/= 1000;
      scaleIndex++;
    }

    return parts.join(' ');
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

  // Currency data for German
  static const Map<String, Map<String, String>> _currencyData = {
    'USD': {
      'major': 'Dollar',
      'majorPlural': 'Dollar',
      'minor': 'Cent',
      'minorPlural': 'Cent',
      'decimals': '2'
    },
    'EUR': {
      'major': 'Euro',
      'majorPlural': 'Euro',
      'minor': 'Cent',
      'minorPlural': 'Cent',
      'decimals': '2'
    },
    'GBP': {
      'major': 'Pfund',
      'majorPlural': 'Pfund',
      'minor': 'Pence',
      'minorPlural': 'Pence',
      'decimals': '2'
    },
    'JPY': {
      'major': 'Yen',
      'majorPlural': 'Yen',
      'minor': '',
      'minorPlural': '',
      'decimals': '0'
    },
    'VND': {
      'major': 'Dong',
      'majorPlural': 'Dong',
      'minor': 'Xu',
      'minorPlural': 'Xu',
      'decimals': '2'
    },
    'CNY': {
      'major': 'Yuan',
      'majorPlural': 'Yuan',
      'minor': 'Jiao',
      'minorPlural': 'Jiao',
      'decimals': '2'
    },
    'KRW': {
      'major': 'Won',
      'majorPlural': 'Won',
      'minor': '',
      'minorPlural': '',
      'decimals': '0'
    },
    'THB': {
      'major': 'Baht',
      'majorPlural': 'Baht',
      'minor': 'Satang',
      'minorPlural': 'Satang',
      'decimals': '2'
    },
    'SGD': {
      'major': 'Singapur-Dollar',
      'majorPlural': 'Singapur-Dollar',
      'minor': 'Cent',
      'minorPlural': 'Cent',
      'decimals': '2'
    },
    'AUD': {
      'major': 'Australischer Dollar',
      'majorPlural': 'Australische Dollar',
      'minor': 'Cent',
      'minorPlural': 'Cent',
      'decimals': '2'
    },
    'CAD': {
      'major': 'Kanadischer Dollar',
      'majorPlural': 'Kanadische Dollar',
      'minor': 'Cent',
      'minorPlural': 'Cent',
      'decimals': '2'
    },
    'CHF': {
      'major': 'Schweizer Franken',
      'majorPlural': 'Schweizer Franken',
      'minor': 'Rappen',
      'minorPlural': 'Rappen',
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
      result += ' und $minorWords $minorUnit'; // "und" = "and" in German
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
        return 'erste';
      case 2:
        return 'zweite';
      case 3:
        return 'dritte';
      case 4:
        return 'vierte';
      case 5:
        return 'fünfte';
      case 6:
        return 'sechste';
      case 7:
        return 'siebte';
      case 8:
        return 'achte';
      default:
        // For larger numbers, use cardinal + te/ste
        String baseWords = convertIntegerPart(number);
        if (number <= 19) {
          return '${baseWords}te';
        } else {
          return '${baseWords}ste';
        }
    }
  }
}
