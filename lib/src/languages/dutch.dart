import '../language_base.dart';

/// Dutch language implementation for number to words conversion
class DutchNumberToWords extends NumberToWordsLanguage {
  @override
  String get languageCode => 'nl';

  @override
  String get languageName => 'Dutch';

  @override
  String get minusWord => 'min';

  @override
  String get pointWord => 'komma';

  static const String _zero = 'nul';
  static const String _hundred = 'honderd';

  static const List<String> _scaleNames = [
    '',
    'duizend',
    'miljoen',
    'miljard',
    'biljoen',
  ];

  static const List<String> _numNames = [
    '',
    'een',
    'twee',
    'drie',
    'vier',
    'vijf',
    'zes',
    'zeven',
    'acht',
    'negen',
    'tien',
    'elf',
    'twaalf',
    'dertien',
    'veertien',
    'vijftien',
    'zestien',
    'zeventien',
    'achttien',
    'negentien'
  ];

  static const List<String> _tensNames = [
    '',
    'tien',
    'twintig',
    'dertig',
    'veertig',
    'vijftig',
    'zestig',
    'zeventig',
    'tachtig',
    'negentig'
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

    // Handle tens and ones (Dutch specific: ones before tens with "en")
    if (number >= 20) {
      int tens = number ~/ 10;
      int ones = number % 10;

      String tensResult = _tensNames[tens];
      if (ones > 0) {
        tensResult = '${_numNames[ones]}en$tensResult';
      }

      if (result.isNotEmpty) {
        result += tensResult;
      } else {
        result = tensResult;
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
            // For thousands
            part += _scaleNames[scaleIndex];
          } else {
            // For millions, billions, etc.
            if (remainder == 1) {
              part = 'een ${_scaleNames[scaleIndex]}';
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

  // Currency data for Dutch
  static const Map<String, Map<String, String>> _currencyData = {
    'USD': {
      'major': 'dollar',
      'majorPlural': 'dollars',
      'minor': 'cent',
      'minorPlural': 'cents',
      'decimals': '2'
    },
    'EUR': {
      'major': 'euro',
      'majorPlural': 'euros',
      'minor': 'cent',
      'minorPlural': 'cents',
      'decimals': '2'
    },
    'GBP': {
      'major': 'pond',
      'majorPlural': 'pond',
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
      'major': 'Singapore dollar',
      'majorPlural': 'Singapore dollars',
      'minor': 'cent',
      'minorPlural': 'cents',
      'decimals': '2'
    },
    'AUD': {
      'major': 'Australische dollar',
      'majorPlural': 'Australische dollars',
      'minor': 'cent',
      'minorPlural': 'cents',
      'decimals': '2'
    },
    'CAD': {
      'major': 'Canadese dollar',
      'majorPlural': 'Canadese dollars',
      'minor': 'cent',
      'minorPlural': 'cents',
      'decimals': '2'
    },
    'CHF': {
      'major': 'Zwitserse frank',
      'majorPlural': 'Zwitserse franken',
      'minor': 'centime',
      'minorPlural': 'centimes',
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
      result += ' en $minorWords $minorUnit'; // "en" = "and" in Dutch
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
        return 'eerste';
      case 2:
        return 'tweede';
      case 3:
        return 'derde';
      case 4:
        return 'vierde';
      case 5:
        return 'vijfde';
      case 6:
        return 'zesde';
      case 7:
        return 'zevende';
      case 8:
        return 'achtste';
      default:
        // For larger numbers, use cardinal + de/ste
        String baseWords = convertIntegerPart(number);
        if (number <= 19) {
          return '${baseWords}de';
        } else {
          return '${baseWords}ste';
        }
    }
  }
}
