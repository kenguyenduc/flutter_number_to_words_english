import '../language_base.dart';

/// English language implementation for number to words conversion
class EnglishNumberToWords extends NumberToWordsLanguage {
  @override
  String get languageCode => 'en';

  @override
  String get languageName => 'English';

  @override
  String get minusWord => 'minus';

  @override
  String get pointWord => 'point';

  static const String _unionSeparator = '-';
  static const String _zero = 'zero';
  static const String _hundred = 'hundred';

  // Scale names
  static const List<String> _scaleNames = [
    '',
    'thousand',
    'million',
    'billion',
    'trillion',
    'quadrillion',
    'quintillion',
    'sextillion',
    'septillion',
    'octillion',
    'nonillion',
    'decillion'
  ];

  static const List<String> _numNames = [
    '',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen'
  ];

  static const List<String> _tensNames = [
    '',
    'ten',
    'twenty',
    'thirty',
    'forty',
    'fifty',
    'sixty',
    'seventy',
    'eighty',
    'ninety'
  ];

  @override
  String convertLessThanOneThousand(int number) {
    String soFar = '';

    if (number % 100 < 20) {
      soFar = _numNames[number % 100];
      number = number ~/ 100;
    } else {
      final int numFirst = number;
      soFar = _numNames[number % 10];
      number = number ~/ 10;
      final String unionSeparator =
          ((number ~/ 10) != 0 && numFirst % 10 != 0) ||
                  (numFirst % 10 != 0 && numFirst < 100)
              ? _unionSeparator
              : '';
      soFar = _tensNames[number % 10] + unionSeparator + soFar;
      number = number ~/ 10;
    }
    if (number == 0) {
      return soFar;
    }
    return '${_numNames[number]} $_hundred $soFar';
  }

  @override
  String convertIntegerPart(int number) {
    if (number == 0) {
      return _zero;
    }

    // Pad to 36 digits for decillion
    final String strNumber = number.toString().padLeft(36, '0');

    // Break into groups of 3
    final int totalGroups = (strNumber.length / 3).round();
    final List<String> groups = [];
    for (int i = 0; i < totalGroups; i++) {
      final start = i * 3;
      final end = start + 3;
      groups.add(strNumber.substring(start, end));
    }

    final List<int> intGroups = groups.map((g) => int.parse(g)).toList();
    String result = '';

    for (int i = 0; i < totalGroups; i++) {
      int groupValue = intGroups[i];
      if (groupValue > 0) {
        int scaleIndex = totalGroups - 1 - i;
        String partial = convertLessThanOneThousand(groupValue);
        String scaleName = _scaleNames[scaleIndex];
        if (scaleName.isNotEmpty) {
          partial = '$partial $scaleName ';
        } else {
          partial = '$partial ';
        }
        result += partial;
      }
    }

    // Clean up spaces
    result = result.replaceAll(RegExp('\\s+'), ' ').trim();
    return result.isEmpty ? _zero : result;
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

    // Split into integer and decimal parts
    List<String> parts = numberStr.split('.');
    String integerPartStr = parts[0];
    String decimalPartStr = parts.length > 1 ? parts[1] : '';

    // Convert integer part
    int integerPart = int.parse(integerPartStr);
    String integerWords = convertIntegerPart(integerPart);

    // If no decimal part
    if (decimalPartStr.isEmpty) {
      return (isNegative ? '$minusWord ' : '') + integerWords;
    }

    // If there's a decimal part, read each digit
    String decimalWords = pointWord;
    for (int i = 0; i < decimalPartStr.length; i++) {
      int digit = int.parse(decimalPartStr[i]);
      decimalWords += ' ${_numNames[digit]}';
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
      // Convert double to string and then to words
      return convertDecimal(number.toString());
    }
  }

  // Currency data for English
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
      'major': 'pound',
      'majorPlural': 'pounds',
      'minor': 'pence',
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
      'major': 'Australian dollar',
      'majorPlural': 'Australian dollars',
      'minor': 'cent',
      'minorPlural': 'cents',
      'decimals': '2'
    },
    'CAD': {
      'major': 'Canadian dollar',
      'majorPlural': 'Canadian dollars',
      'minor': 'cent',
      'minorPlural': 'cents',
      'decimals': '2'
    },
    'CHF': {
      'major': 'Swiss franc',
      'majorPlural': 'Swiss francs',
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
      result += ' and $minorWords $minorUnit';
    }

    return result;
  }

  @override
  String convertOrdinal(int number) {
    if (number <= 0) {
      throw ArgumentError('Ordinal numbers must be positive integers');
    }

    // Special individual cases
    switch (number) {
      case 1:
        return 'first';
      case 2:
        return 'second';
      case 3:
        return 'third';
      case 4:
        return 'fourth';
      case 5:
        return 'fifth';
      case 6:
        return 'sixth';
      case 7:
        return 'seventh';
      case 8:
        return 'eighth';
      case 9:
        return 'ninth';
      case 10:
        return 'tenth';
      case 11:
        return 'eleventh';
      case 12:
        return 'twelfth';
      case 13:
        return 'thirteenth';
      case 14:
        return 'fourteenth';
      case 15:
        return 'fifteenth';
      case 16:
        return 'sixteenth';
      case 17:
        return 'seventeenth';
      case 18:
        return 'eighteenth';
      case 19:
        return 'nineteenth';
      case 20:
        return 'twentieth';
      case 30:
        return 'thirtieth';
      case 40:
        return 'fortieth';
      case 50:
        return 'fiftieth';
      case 60:
        return 'sixtieth';
      case 70:
        return 'seventieth';
      case 80:
        return 'eightieth';
      case 90:
        return 'ninetieth';
    }

    // For larger numbers, handle compound ordinals
    int lastTwoDigits = number % 100;
    if (lastTwoDigits >= 11 && lastTwoDigits <= 13) {
      return '${convertIntegerPart(number)}th';
    }

    // Check last digit for specific ordinal endings
    int lastDigit = number % 10;
    String baseWords = convertIntegerPart(number);

    switch (lastDigit) {
      case 1:
        if (baseWords.endsWith(' one')) {
          return baseWords.substring(0, baseWords.length - 4) + ' first';
        } else if (baseWords.endsWith('-one')) {
          return baseWords.substring(0, baseWords.length - 4) + '-first';
        } else {
          return '${baseWords}st';
        }
      case 2:
        if (baseWords.endsWith(' two')) {
          return baseWords.substring(0, baseWords.length - 4) + ' second';
        } else if (baseWords.endsWith('-two')) {
          return baseWords.substring(0, baseWords.length - 4) + '-second';
        } else {
          return '${baseWords}nd';
        }
      case 3:
        if (baseWords.endsWith(' three')) {
          return baseWords.substring(0, baseWords.length - 6) + ' third';
        } else if (baseWords.endsWith('-three')) {
          return baseWords.substring(0, baseWords.length - 6) + '-third';
        } else {
          return '${baseWords}rd';
        }
      case 5:
        if (baseWords.endsWith(' five')) {
          return baseWords.substring(0, baseWords.length - 5) + ' fifth';
        } else if (baseWords.endsWith('-five')) {
          return baseWords.substring(0, baseWords.length - 5) + '-fifth';
        } else {
          return '${baseWords}th';
        }
      default:
        return '${baseWords}th';
    }
  }
}
