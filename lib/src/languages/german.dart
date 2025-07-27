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
      if (hundreds == 1) {
        result = 'ein$_hundred';
      } else {
        result = '${_numNames[hundreds]}$_hundred';
      }
      number %= 100;
    }

    // Handle tens and ones (German specific: ones before tens)
    if (number >= 20) {
      int tens = number ~/ 10;
      int ones = number % 10;

      String tensResult = _tensNames[tens];
      if (ones > 0) {
        String onesWord = ones == 1 ? 'ein' : _numNames[ones];
        tensResult = '${onesWord}und$tensResult';
      }

      if (result.isNotEmpty) {
        result += tensResult;
      } else {
        result = tensResult;
      }
    } else if (number > 0) {
      String onesWord = '';
      if (number == 1) {
        onesWord = result.isEmpty ? 'eins' : 'ein';
      } else {
        onesWord = _numNames[number];
      }

      if (result.isNotEmpty) {
        result += onesWord;
      } else {
        result = onesWord;
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
          // Special handling for German
          if (scaleIndex == 1) {
            // For thousands, just add "tausend"
            part += _scaleNames[scaleIndex];
          } else {
            // For millions, billions, etc.
            if (remainder == 1) {
              part = 'eine ${_scaleNames[scaleIndex]}';
            } else {
              part += ' ${_scaleNames[scaleIndex]}en';
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
}
