import '../language_base.dart';

/// French language implementation for number to words conversion
class FrenchNumberToWords extends NumberToWordsLanguage {
  @override
  String get languageCode => 'fr';

  @override
  String get languageName => 'French';

  @override
  String get minusWord => 'moins';

  @override
  String get pointWord => 'virgule';

  static const String _zero = 'zéro';
  static const String _hundred = 'cent';

  static const List<String> _scaleNames = [
    '',
    'mille',
    'million',
    'milliard',
    'billion',
  ];

  static const List<String> _numNames = [
    '',
    'un',
    'deux',
    'trois',
    'quatre',
    'cinq',
    'six',
    'sept',
    'huit',
    'neuf',
    'dix',
    'onze',
    'douze',
    'treize',
    'quatorze',
    'quinze',
    'seize',
    'dix-sept',
    'dix-huit',
    'dix-neuf',
    'vingt',
    'vingt et un',
    'vingt-deux',
    'vingt-trois',
    'vingt-quatre',
    'vingt-cinq',
    'vingt-six',
    'vingt-sept',
    'vingt-huit',
    'vingt-neuf',
    'trente',
    'trente et un',
    'trente-deux',
    'trente-trois',
    'trente-quatre',
    'trente-cinq',
    'trente-six',
    'trente-sept',
    'trente-huit',
    'trente-neuf',
    'quarante',
    'quarante et un',
    'quarante-deux',
    'quarante-trois',
    'quarante-quatre',
    'quarante-cinq',
    'quarante-six',
    'quarante-sept',
    'quarante-huit',
    'quarante-neuf',
    'cinquante',
    'cinquante et un',
    'cinquante-deux',
    'cinquante-trois',
    'cinquante-quatre',
    'cinquante-cinq',
    'cinquante-six',
    'cinquante-sept',
    'cinquante-huit',
    'cinquante-neuf',
    'soixante',
    'soixante et un',
    'soixante-deux',
    'soixante-trois',
    'soixante-quatre',
    'soixante-cinq',
    'soixante-six',
    'soixante-sept',
    'soixante-huit',
    'soixante-neuf',
    'soixante-dix',
    'soixante et onze',
    'soixante-douze',
    'soixante-treize',
    'soixante-quatorze',
    'soixante-quinze',
    'soixante-seize',
    'soixante-dix-sept',
    'soixante-dix-huit',
    'soixante-dix-neuf',
    'quatre-vingts',
    'quatre-vingt-un',
    'quatre-vingt-deux',
    'quatre-vingt-trois',
    'quatre-vingt-quatre',
    'quatre-vingt-cinq',
    'quatre-vingt-six',
    'quatre-vingt-sept',
    'quatre-vingt-huit',
    'quatre-vingt-neuf',
    'quatre-vingt-dix',
    'quatre-vingt-onze',
    'quatre-vingt-douze',
    'quatre-vingt-treize',
    'quatre-vingt-quatorze',
    'quatre-vingt-quinze',
    'quatre-vingt-seize',
    'quatre-vingt-dix-sept',
    'quatre-vingt-dix-huit',
    'quatre-vingt-dix-neuf'
  ];

  @override
  String convertLessThanOneThousand(int number) {
    if (number == 0) return '';

    if (number < 100) {
      return _numNames[number];
    }

    String result = '';
    int hundreds = number ~/ 100;
    int remainder = number % 100;

    if (hundreds == 1) {
      result = _hundred;
    } else {
      result = '${_numNames[hundreds]} ${_hundred}s';
    }

    if (remainder > 0) {
      result += ' ${_numNames[remainder]}';
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
          // Special case for "mille" - don't say "un mille", just "mille"
          if (scaleIndex == 1 && remainder == 1) {
            part = _scaleNames[scaleIndex];
          } else {
            part += ' ${_scaleNames[scaleIndex]}';
            // Add 's' for plural millions, milliards, etc.
            if (scaleIndex > 1 && remainder > 1) {
              part += 's';
            }
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

  // Currency data for French
  static const Map<String, Map<String, String>> _currencyData = {
    'USD': {
      'major': 'dollar',
      'majorPlural': 'dollars',
      'minor': 'centime',
      'minorPlural': 'centimes',
      'decimals': '2'
    },
    'EUR': {
      'major': 'euro',
      'majorPlural': 'euros',
      'minor': 'centime',
      'minorPlural': 'centimes',
      'decimals': '2'
    },
    'GBP': {
      'major': 'livre',
      'majorPlural': 'livres',
      'minor': 'penny',
      'minorPlural': 'pence',
      'decimals': '2'
    },
    'JPY': {
      'major': 'yen',
      'majorPlural': 'yens',
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
      'major': 'dollar de Singapour',
      'majorPlural': 'dollars de Singapour',
      'minor': 'centime',
      'minorPlural': 'centimes',
      'decimals': '2'
    },
    'AUD': {
      'major': 'dollar australien',
      'majorPlural': 'dollars australiens',
      'minor': 'centime',
      'minorPlural': 'centimes',
      'decimals': '2'
    },
    'CAD': {
      'major': 'dollar canadien',
      'majorPlural': 'dollars canadiens',
      'minor': 'centime',
      'minorPlural': 'centimes',
      'decimals': '2'
    },
    'CHF': {
      'major': 'franc suisse',
      'majorPlural': 'francs suisses',
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
      result += ' et $minorWords $minorUnit'; // "et" = "and" in French
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
        return 'premier';
      case 2:
        return 'deuxième';
      case 3:
        return 'troisième';
      case 4:
        return 'quatrième';
      case 5:
        return 'cinquième';
      case 6:
        return 'sixième';
      case 7:
        return 'septième';
      case 8:
        return 'huitième';
      case 9:
        return 'neuvième';
      case 10:
        return 'dixième';
      default:
        // For larger numbers, use cardinal + ième
        String baseWords = convertIntegerPart(number);
        return '${baseWords}ième';
    }
  }
}
