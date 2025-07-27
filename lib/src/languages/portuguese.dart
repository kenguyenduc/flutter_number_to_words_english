import '../language_base.dart';

/// Portuguese language implementation for number to words conversion
class PortugueseNumberToWords extends NumberToWordsLanguage {
  @override
  String get languageCode => 'pt';

  @override
  String get languageName => 'Portuguese';

  @override
  String get minusWord => 'menos';

  @override
  String get pointWord => 'vírgula';

  static const String _zero = 'zero';
  static const String _hundred = 'cem';

  static const List<String> _scaleNames = [
    '',
    'mil',
    'milhão',
    'bilhão',
    'trilhão',
  ];

  static const List<String> _numNames = [
    '',
    'um',
    'dois',
    'três',
    'quatro',
    'cinco',
    'seis',
    'sete',
    'oito',
    'nove',
    'dez',
    'onze',
    'doze',
    'treze',
    'quatorze',
    'quinze',
    'dezesseis',
    'dezessete',
    'dezoito',
    'dezenove'
  ];

  static const List<String> _tensNames = [
    '',
    'dez',
    'vinte',
    'trinta',
    'quarenta',
    'cinquenta',
    'sessenta',
    'setenta',
    'oitenta',
    'noventa'
  ];

  @override
  String convertLessThanOneThousand(int number) {
    if (number == 0) return '';

    String result = '';

    // Handle hundreds
    if (number >= 100) {
      int hundreds = number ~/ 100;
      if (hundreds == 1) {
        result = number == 100 ? _hundred : 'cento';
      } else {
        result = '${_numNames[hundreds]}centos';
      }
      number %= 100;
      if (number > 0) result += ' e ';
    }

    // Handle tens and ones
    if (number >= 20) {
      int tens = number ~/ 10;
      result += _tensNames[tens];
      number %= 10;
      if (number > 0) {
        result += ' e ${_numNames[number]}';
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
          if (scaleIndex == 1) {
            // Thousands
            part += ' ${_scaleNames[scaleIndex]}';
          } else {
            // Millions, billions, etc.
            if (remainder == 1) {
              part = 'um ${_scaleNames[scaleIndex]}';
            } else {
              String scale = _scaleNames[scaleIndex];
              if (scale.endsWith('ão')) {
                scale = '${scale.substring(0, scale.length - 2)}ões';
              }
              part += ' $scale';
            }
          }
        }
        parts.insert(0, part);
      }
      number ~/= 1000;
      scaleIndex++;
    }

    return parts.join(' e ');
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

  // Currency data for Portuguese
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
      'minor': 'penny',
      'minorPlural': 'pence',
      'decimals': '2'
    },
    'JPY': {
      'major': 'iene',
      'majorPlural': 'ienes',
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
      'major': 'dólar de Singapura',
      'majorPlural': 'dólares de Singapura',
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
      'major': 'dólar canadense',
      'majorPlural': 'dólares canadenses',
      'minor': 'centavo',
      'minorPlural': 'centavos',
      'decimals': '2'
    },
    'CHF': {
      'major': 'franco suíço',
      'majorPlural': 'francos suíços',
      'minor': 'cêntimo',
      'minorPlural': 'cêntimos',
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
      result += ' e $minorWords $minorUnit'; // "e" = "and" in Portuguese
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
        return 'primeiro';
      case 2:
        return 'segundo';
      case 3:
        return 'terceiro';
      case 4:
        return 'quarto';
      case 5:
        return 'quinto';
      case 6:
        return 'sexto';
      case 7:
        return 'sétimo';
      case 8:
        return 'oitavo';
      case 9:
        return 'nono';
      case 10:
        return 'décimo';
      default:
        // For larger numbers, use cardinal + º
        String baseWords = convertIntegerPart(number);
        return '$baseWordsº';
    }
  }
}
