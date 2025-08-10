import '../language_base.dart';

/// Russian language implementation for number to words conversion
class RussianNumberToWords extends NumberToWordsLanguage {
  @override
  String get languageCode => 'ru';

  @override
  String get languageName => 'Russian';

  @override
  String get minusWord => 'минус';

  @override
  String get pointWord => 'запятая';

  static const String _zero = 'ноль';
  // static const String _hundred = 'сто'; // For future use

  static const List<String> _scaleNames = [
    '',
    'тысяча',
    'миллион',
    'миллиард',
    'триллион',
  ];

  static const List<String> _numNames = [
    '',
    'один',
    'два',
    'три',
    'четыре',
    'пять',
    'шесть',
    'семь',
    'восемь',
    'девять',
    'десять',
    'одиннадцать',
    'двенадцать',
    'тринадцать',
    'четырнадцать',
    'пятнадцать',
    'шестнадцать',
    'семнадцать',
    'восемнадцать',
    'девятнадцать'
  ];

  // For thousands - feminine form
  static const List<String> _numNamesFeminine = [
    '',
    'одна', // feminine form of "один" for thousands
    'две', // feminine form of "два" for thousands
    'три',
    'четыре',
    'пять',
    'шесть',
    'семь',
    'восемь',
    'девять',
    'десять',
    'одиннадцать',
    'двенадцать',
    'тринадцать',
    'четырнадцать',
    'пятнадцать',
    'шестнадцать',
    'семнадцать',
    'восемнадцать',
    'девятнадцать'
  ];

  static const List<String> _tensNames = [
    '',
    'десять',
    'двадцать',
    'тридцать',
    'сорок',
    'пятьдесят',
    'шестьдесят',
    'семьдесят',
    'восемьдесят',
    'девяносто'
  ];

  static const List<String> _hundredsNames = [
    '',
    'сто',
    'двести',
    'триста',
    'четыреста',
    'пятьсот',
    'шестьсот',
    'семьсот',
    'восемьсот',
    'девятьсот'
  ];

  String _convertLessThanOneThousandInternal(int number,
      {bool feminine = false}) {
    if (number == 0) return '';

    String result = '';
    final numNames = feminine ? _numNamesFeminine : _numNames;

    // Handle hundreds
    if (number >= 100) {
      int hundreds = number ~/ 100;
      result = _hundredsNames[hundreds];
      number %= 100;
      if (number > 0) result += ' ';
    }

    // Handle tens and ones
    if (number >= 20) {
      int tens = number ~/ 10;
      result += _tensNames[tens];
      number %= 10;
      if (number > 0) {
        result += ' ${numNames[number]}';
      }
    } else if (number > 0) {
      result += numNames[number];
    }

    return result;
  }

  @override
  String convertLessThanOneThousand(int number) {
    return _convertLessThanOneThousandInternal(number, feminine: false);
  }

  @override
  String convertIntegerPart(int number) {
    if (number == 0) return _zero;

    if (number < 1000) {
      return _convertLessThanOneThousandInternal(number);
    }

    List<String> parts = [];
    int scaleIndex = 0;

    while (number > 0 && scaleIndex < _scaleNames.length) {
      int remainder = number % 1000;
      if (remainder > 0) {
        String part;
        if (scaleIndex == 1) {
          // For thousands, use feminine form
          part = _convertLessThanOneThousandInternal(remainder, feminine: true);
          part += ' ${_scaleNames[scaleIndex]}';
        } else {
          part = _convertLessThanOneThousandInternal(remainder);
          if (scaleIndex > 0) {
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

  // Currency data for Russian
  static const Map<String, Map<String, String>> _currencyData = {
    'USD': {
      'major': 'доллар',
      'majorPlural': 'долларов',
      'minor': 'цент',
      'minorPlural': 'центов',
      'decimals': '2'
    },
    'EUR': {
      'major': 'евро',
      'majorPlural': 'евро',
      'minor': 'цент',
      'minorPlural': 'центов',
      'decimals': '2'
    },
    'GBP': {
      'major': 'фунт',
      'majorPlural': 'фунтов',
      'minor': 'пенс',
      'minorPlural': 'пенсов',
      'decimals': '2'
    },
    'JPY': {
      'major': 'иена',
      'majorPlural': 'иен',
      'minor': '',
      'minorPlural': '',
      'decimals': '0'
    },
    'VND': {
      'major': 'донг',
      'majorPlural': 'донгов',
      'minor': 'ксу',
      'minorPlural': 'ксу',
      'decimals': '2'
    },
    'CNY': {
      'major': 'юань',
      'majorPlural': 'юаней',
      'minor': 'цзяо',
      'minorPlural': 'цзяо',
      'decimals': '2'
    },
    'KRW': {
      'major': 'вона',
      'majorPlural': 'вон',
      'minor': '',
      'minorPlural': '',
      'decimals': '0'
    },
    'THB': {
      'major': 'бат',
      'majorPlural': 'батов',
      'minor': 'сатанг',
      'minorPlural': 'сатангов',
      'decimals': '2'
    },
    'SGD': {
      'major': 'сингапурский доллар',
      'majorPlural': 'сингапурских долларов',
      'minor': 'цент',
      'minorPlural': 'центов',
      'decimals': '2'
    },
    'AUD': {
      'major': 'австралийский доллар',
      'majorPlural': 'австралийских долларов',
      'minor': 'цент',
      'minorPlural': 'центов',
      'decimals': '2'
    },
    'CAD': {
      'major': 'канадский доллар',
      'majorPlural': 'канадских долларов',
      'minor': 'цент',
      'minorPlural': 'центов',
      'decimals': '2'
    },
    'CHF': {
      'major': 'швейцарский франк',
      'majorPlural': 'швейцарских франков',
      'minor': 'сантим',
      'minorPlural': 'сантимов',
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
      result += ' и $minorWords $minorUnit'; // "и" = "and" in Russian
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
        return 'первый';
      case 2:
        return 'второй';
      case 3:
        return 'третий';
      case 4:
        return 'четвёртый';
      case 5:
        return 'пятый';
      case 6:
        return 'шестой';
      case 7:
        return 'седьмой';
      case 8:
        return 'восьмой';
      case 9:
        return 'девятый';
      case 10:
        return 'десятый';
      default:
        // For larger numbers, use simplified approach
        String baseWords = convertIntegerPart(number);
        return '$baseWords-й'; // Simplified ordinal marker
    }
  }
}
