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
}
