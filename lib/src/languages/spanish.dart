import '../language_base.dart';

/// Spanish language implementation for number to words conversion
class SpanishNumberToWords extends NumberToWordsLanguage {
  @override
  String get languageCode => 'es';

  @override
  String get languageName => 'Spanish';

  @override
  String get minusWord => 'menos';

  @override
  String get pointWord => 'punto';

  static const String _zero = 'cero';
  static const String _hundred = 'ciento';

  static const List<String> _scaleNames = [
    '',
    'mil',
    'millón',
    'mil millones',
    'billón',
  ];

  static const List<String> _numNames = [
    '',
    'uno',
    'dos',
    'tres',
    'cuatro',
    'cinco',
    'seis',
    'siete',
    'ocho',
    'nueve',
    'diez',
    'once',
    'doce',
    'trece',
    'catorce',
    'quince',
    'dieciséis',
    'diecisiete',
    'dieciocho',
    'diecinueve',
    'veinte',
    'veintiuno',
    'veintidós',
    'veintitrés',
    'veinticuatro',
    'veinticinco',
    'veintiséis',
    'veintisiete',
    'veintiocho',
    'veintinueve'
  ];

  static const List<String> _tensNames = [
    '',
    'diez',
    'veinte',
    'treinta',
    'cuarenta',
    'cincuenta',
    'sesenta',
    'setenta',
    'ochenta',
    'noventa'
  ];

  @override
  String convertLessThanOneThousand(int number) {
    if (number == 0) return '';

    String result = '';

    if (number >= 100) {
      int hundreds = number ~/ 100;
      if (hundreds == 1) {
        result += number == 100 ? 'cien' : _hundred;
      } else {
        result += '${_numNames[hundreds]}cientos';
      }
      number %= 100;
      if (number > 0) result += ' ';
    }

    // Handle numbers 20-29 specially (veinti...)
    if (number >= 20 && number <= 29) {
      result += _numNames[number];
    } else if (number >= 30) {
      int tens = number ~/ 10;
      result += _tensNames[tens];
      number %= 10;
      if (number > 0) {
        result += ' y ${_numNames[number]}';
      }
    } else if (number > 0) {
      result += _numNames[number];
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
          // Special case for "mil" - don't say "uno mil", just "mil"
          if (scaleIndex == 1 && remainder == 1) {
            part = _scaleNames[scaleIndex];
          } else {
            part += ' ${_scaleNames[scaleIndex]}';
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
      return convertDecimal(number.toString());
    }
  }

  static const List<String> _ordinalNames = [
    '',
    'primero',
    'segundo',
    'tercero',
    'cuarto',
    'quinto',
    'sexto',
    'séptimo',
    'octavo',
    'noveno',
    'décimo',
    'undécimo',
    'duodécimo',
    'decimotercero',
    'decimocuarto',
    'decimoquinto',
    'decimosexto',
    'decimoséptimo',
    'decimoctavo',
    'decimonoveno',
    'vigésimo'
  ];

  // Currency data for Spanish
  static const Map<String, Map<String, String>> _currencyData = {
    'USD': {
      'major': 'dólar',
      'majorPlural': 'dólares',
      'minor': 'centavo',
      'minorPlural': 'centavos',
      'decimals': '2'
    },
    'EUR': {
      'major': 'euro',
      'majorPlural': 'euros',
      'minor': 'centavo',
      'minorPlural': 'centavos',
      'decimals': '2'
    },
    'GBP': {
      'major': 'libra',
      'majorPlural': 'libras',
      'minor': 'penique',
      'minorPlural': 'peniques',
      'decimals': '2'
    },
    'JPY': {
      'major': 'yen',
      'majorPlural': 'yenes',
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
      'majorPlural': 'yuanes',
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
      'major': 'dólar de Singapur',
      'majorPlural': 'dólares de Singapur',
      'minor': 'centavo',
      'minorPlural': 'centavos',
      'decimals': '2'
    },
    'AUD': {
      'major': 'dólar australiano',
      'majorPlural': 'dólares australianos',
      'minor': 'centavo',
      'minorPlural': 'centavos',
      'decimals': '2'
    },
    'CAD': {
      'major': 'dólar canadiense',
      'majorPlural': 'dólares canadienses',
      'minor': 'centavo',
      'minorPlural': 'centavos',
      'decimals': '2'
    },
    'CHF': {
      'major': 'franco suizo',
      'majorPlural': 'francos suizos',
      'minor': 'céntimo',
      'minorPlural': 'céntimos',
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
      result += ' y $minorWords $minorUnit'; // "y" = "and" in Spanish
    }

    return result;
  }

  @override
  String convertOrdinal(int number) {
    if (number <= 0) {
      throw ArgumentError('Ordinal numbers must be positive integers');
    }

    // Use predefined ordinals for 1-20
    if (number <= 20) {
      return _ordinalNames[number];
    }

    // For larger numbers, construct from base + ordinal endings
    // This is a simplified version - Spanish ordinals can be complex
    String baseWords = convertIntegerPart(number);
    return '${baseWords}º'; // Using ordinal symbol for simplicity
  }
}
