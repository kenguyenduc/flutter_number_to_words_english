class NumberToWordsEnglish {
  NumberToWordsEnglish._();

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

  /// Convert a number less than one thousand to words
  static String _convertLessThanOneThousand(int number) {
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

  /// Convert the integer part of the number
  static String _convertIntegerPart(int number) {
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
        String partial = _convertLessThanOneThousand(groupValue);
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

  /// Convert a decimal number string
  static String convertDecimal(String numberStr) {
    if (!RegExp(r'^-?\d+(\.\d+)?$').hasMatch(numberStr)) {
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
    String integerWords = _convertIntegerPart(integerPart);

    // If no decimal part
    if (decimalPartStr.isEmpty) {
      return (isNegative ? 'minus ' : '') + integerWords;
    }

    // If there's a decimal part, read each digit
    String decimalWords = 'point';
    for (int i = 0; i < decimalPartStr.length; i++) {
      int digit = int.parse(decimalPartStr[i]);
      decimalWords += ' ${_numNames[digit]}';
    }

    String result = '$integerWords $decimalWords';
    result = result.replaceAll(RegExp('\\s+'), ' ').trim();
    if (isNegative) {
      result = 'minus $result';
    }
    return result;
  }

  /// Public method to convert a number (int or double) to words.
  static String convert(num number) {
    bool isNegative = number < 0;
    if (number is int) {
      int absNumber = number.abs();
      String words = _convertIntegerPart(absNumber);
      return isNegative ? 'minus $words' : words;
    } else {
      // Convert double to string and then to words
      return convertDecimal(number.toString());
    }
  }
}
