import '../language_base.dart';

/// Chinese (Simplified) language implementation for number to words conversion
class ChineseNumberToWords extends NumberToWordsLanguage {
  @override
  String get languageCode => 'zh';

  @override
  String get languageName => 'Chinese';

  @override
  String get minusWord => '负';

  @override
  String get pointWord => '点';

  static const String _zero = '零';

  // Scale names for future expansion
  // static const List<String> _scaleNames = [
  //   '',
  //   '千',
  //   '万',
  //   '千万',
  //   '亿',
  // ];

  static const List<String> _numNames = [
    '',
    '一',
    '二',
    '三',
    '四',
    '五',
    '六',
    '七',
    '八',
    '九',
    '十',
    '十一',
    '十二',
    '十三',
    '十四',
    '十五',
    '十六',
    '十七',
    '十八',
    '十九'
  ];

  static const List<String> _tensNames = [
    '',
    '十',
    '二十',
    '三十',
    '四十',
    '五十',
    '六十',
    '七十',
    '八十',
    '九十'
  ];

  @override
  String convertLessThanOneThousand(int number) {
    if (number == 0) return '';

    String result = '';

    // Handle hundreds
    if (number >= 100) {
      int hundreds = number ~/ 100;
      result = '${_numNames[hundreds]}百';
      number %= 100;
      if (number > 0 && number < 10) {
        result += _zero; // Add zero for numbers like 105
      }
    }

    // Handle tens and ones
    if (number >= 20) {
      int tens = number ~/ 10;
      result += _tensNames[tens];
      number %= 10;
      if (number > 0) {
        result += _numNames[number];
      }
    } else if (number >= 10) {
      if (result.isEmpty && number < 20) {
        result += _numNames[number];
      } else {
        result += _numNames[number];
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

    String result = '';

    // Handle 万 (ten thousands)
    if (number >= 10000) {
      int tenThousands = number ~/ 10000;
      result += '${convertLessThanOneThousand(tenThousands)}万';
      number %= 10000;
      if (number > 0 && number < 1000) {
        result += _zero; // Add zero for numbers like 10005
      }
    }

    // Handle thousands
    if (number >= 1000) {
      int thousands = number ~/ 1000;
      result += '${_numNames[thousands]}千';
      number %= 1000;
      if (number > 0 && number < 100) {
        result += _zero; // Add zero for numbers like 1005
      }
    }

    // Handle remaining hundreds, tens, ones
    if (number > 0) {
      result += convertLessThanOneThousand(number);
    }

    return result;
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
      return '${isNegative ? minusWord : ''}$integerWords';
    }

    String decimalWords = pointWord;
    for (int i = 0; i < decimalPartStr.length; i++) {
      int digit = int.parse(decimalPartStr[i]);
      decimalWords += _numNames[digit];
    }

    String result = '$integerWords$decimalWords';
    if (isNegative) {
      result = '$minusWord$result';
    }
    return result;
  }

  @override
  String convert(num number) {
    bool isNegative = number < 0;
    if (number is int) {
      int absNumber = number.abs();
      String words = convertIntegerPart(absNumber);
      return isNegative ? '$minusWord$words' : words;
    } else {
      return convertDecimal(number.toString());
    }
  }

  // Currency data for Chinese
  static const Map<String, Map<String, String>> _currencyData = {
    'USD': {
      'major': '美元',
      'majorPlural': '美元',
      'minor': '美分',
      'minorPlural': '美分',
      'decimals': '2'
    },
    'EUR': {
      'major': '欧元',
      'majorPlural': '欧元',
      'minor': '欧分',
      'minorPlural': '欧分',
      'decimals': '2'
    },
    'GBP': {
      'major': '英镑',
      'majorPlural': '英镑',
      'minor': '便士',
      'minorPlural': '便士',
      'decimals': '2'
    },
    'JPY': {
      'major': '日元',
      'majorPlural': '日元',
      'minor': '',
      'minorPlural': '',
      'decimals': '0'
    },
    'VND': {
      'major': '越南盾',
      'majorPlural': '越南盾',
      'minor': '徐',
      'minorPlural': '徐',
      'decimals': '2'
    },
    'CNY': {
      'major': '人民币',
      'majorPlural': '人民币',
      'minor': '角',
      'minorPlural': '角',
      'decimals': '2'
    },
    'KRW': {
      'major': '韩元',
      'majorPlural': '韩元',
      'minor': '',
      'minorPlural': '',
      'decimals': '0'
    },
    'THB': {
      'major': '泰铢',
      'majorPlural': '泰铢',
      'minor': '萨当',
      'minorPlural': '萨当',
      'decimals': '2'
    },
    'SGD': {
      'major': '新加坡元',
      'majorPlural': '新加坡元',
      'minor': '分',
      'minorPlural': '分',
      'decimals': '2'
    },
    'AUD': {
      'major': '澳元',
      'majorPlural': '澳元',
      'minor': '分',
      'minorPlural': '分',
      'decimals': '2'
    },
    'CAD': {
      'major': '加元',
      'majorPlural': '加元',
      'minor': '分',
      'minorPlural': '分',
      'decimals': '2'
    },
    'CHF': {
      'major': '瑞士法郎',
      'majorPlural': '瑞士法郎',
      'minor': '生丁',
      'minorPlural': '生丁',
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
    String majorUnit = currency['major']!; // Chinese doesn't change for plural
    String result = '$majorWords$majorUnit';

    // Add minor amount if applicable
    if (decimals > 0 && minorAmount > 0) {
      String minorWords = convertIntegerPart(minorAmount);
      String minorUnit = currency['minor']!;
      result += '$minorWords$minorUnit';
    }

    return result;
  }

  @override
  String convertOrdinal(int number) {
    if (number <= 0) {
      throw ArgumentError('Ordinal numbers must be positive integers');
    }

    // In Chinese, ordinals are formed by adding "第" before the cardinal number
    String cardinalWords = convertIntegerPart(number);
    return '第$cardinalWords';
  }
}
