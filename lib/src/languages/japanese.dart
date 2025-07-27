import '../language_base.dart';

/// Japanese language implementation for number to words conversion
class JapaneseNumberToWords extends NumberToWordsLanguage {
  @override
  String get languageCode => 'ja';

  @override
  String get languageName => 'Japanese';

  @override
  String get minusWord => 'マイナス';

  @override
  String get pointWord => 'テン';

  static const String _zero = 'ゼロ';

  // Scale names for future expansion
  // static const List<String> _scaleNames = [
  //   '',
  //   '千',
  //   '万',
  //   '千万',
  //   '億',
  // ];

  static const List<String> _numNames = [
    '',
    'いち',
    'に',
    'さん',
    'よん',
    'ご',
    'ろく',
    'なな',
    'はち',
    'きゅう',
    'じゅう'
  ];

  static const List<String> _tensNames = [
    '',
    'じゅう',
    'にじゅう',
    'さんじゅう',
    'よんじゅう',
    'ごじゅう',
    'ろくじゅう',
    'ななじゅう',
    'はちじゅう',
    'きゅうじゅう'
  ];

  @override
  String convertLessThanOneThousand(int number) {
    if (number == 0) return '';

    String result = '';

    // Handle hundreds
    if (number >= 100) {
      int hundreds = number ~/ 100;
      if (hundreds == 1) {
        result = 'ひゃく';
      } else if (hundreds == 3) {
        result = 'さんびゃく';
      } else if (hundreds == 6) {
        result = 'ろっぴゃく';
      } else if (hundreds == 8) {
        result = 'はっぴゃく';
      } else {
        result = '${_numNames[hundreds]}ひゃく';
      }
      number %= 100;
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
      if (number == 10) {
        result += 'じゅう';
      } else {
        result += 'じゅう${_numNames[number % 10]}';
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
      if (tenThousands == 1) {
        result += 'いちまん';
      } else {
        result += convertLessThanOneThousand(tenThousands) + 'まん';
      }
      number %= 10000;
    }

    // Handle thousands
    if (number >= 1000) {
      int thousands = number ~/ 1000;
      if (thousands == 1) {
        result += 'せん';
      } else if (thousands == 3) {
        result += 'さんぜん';
      } else if (thousands == 8) {
        result += 'はっせん';
      } else {
        result += '${_numNames[thousands]}せん';
      }
      number %= 1000;
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
      return (isNegative ? minusWord : '') + integerWords;
    }

    String decimalWords = pointWord;
    for (int i = 0; i < decimalPartStr.length; i++) {
      int digit = int.parse(decimalPartStr[i]);
      if (digit == 0) {
        decimalWords += _zero;
      } else {
        decimalWords += _numNames[digit];
      }
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

  @override
  String convertOrdinal(int number) {
    if (number <= 0) {
      throw ArgumentError('Ordinal numbers must be positive integers');
    }

    // In Japanese, ordinals are formed by adding "第" before and "番目" or just "番" after
    String cardinalWords = convertIntegerPart(number);
    return '第${cardinalWords}番目';
  }
}
