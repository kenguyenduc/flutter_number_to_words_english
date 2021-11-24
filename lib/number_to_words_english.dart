class NumberToWordsEnglish {
  NumberToWordsEnglish._();

  static const String _unionSeparator = '-';
  static const String _zero = 'zero'; //0
  static const String _hundred = 'hundred'; //100
  static const String _thousand = 'thousand'; //1000
  static const String _million = 'million'; //1000 000
  static const String _billion = 'billion'; //1000 000 000

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

  static String _convertLessThanOneThousand(int number,
      [bool isLastThreeDigits = false]) {
    String soFar = '';

    if (number % 100 < 20) {
      soFar = _numNames[number % 100];
      number = (number ~/ 100).toInt();
    } else {
      final int numFirst = number;
      soFar = _numNames[number % 10];
      number = (number ~/ 10).toInt();
      final String unionSeparator =
          ((number ~/ 10).toInt() != 0 && numFirst % 10 != 0) ||
                  (numFirst % 10 != 0 && numFirst < 100)
              ? _unionSeparator
              : '';
      soFar = _tensNames[number % 10] + unionSeparator + soFar;
      number = (number ~/ 10).toInt();
    }
    if (number == 0) {
      return soFar;
    }
    return _numNames[number] + ' $_hundred ' + soFar;
  }

  static String convert(int number) {
    // 0 to 999 999 999 999
    if (number == 0) {
      return _zero;
    }
    final String strNumber = number.toString().padLeft(12, '0');
    // XXXnnnnnnnnn
    final int billions = int.parse(strNumber.substring(0, 3));
    // nnnXXXnnnnnn
    final int millions = int.parse(strNumber.substring(3, 6));
    // nnnnnnXXXnnn
    final int hundredThousands = int.parse(strNumber.substring(6, 9));
    // nnnnnnnnnXXX
    final int thousands = int.parse(strNumber.substring(9, 12));

    final String tradBillions = _getBillions(billions);
    String result = tradBillions;

    final String tradMillions = _getMillions(millions);
    result = result + tradMillions;

    final String tradHundredThousands = _getThousands(hundredThousands);
    result = result + tradHundredThousands;

    String tradThousand;
    tradThousand = _convertLessThanOneThousand(thousands, true);
    result = result + tradThousand;

    // remove extra spaces!
    result =
        result.replaceAll(RegExp('\\s+'), ' ').replaceAll('\\b\\s{2,}\\b', ' ');
    return result.trim();
  }

  static String _getBillions(int billions) {
    String tradBillions;
    switch (billions) {
      case 0:
        tradBillions = '';
        break;
      case 1:
        tradBillions = _convertLessThanOneThousand(billions) + ' $_billion ';
        break;
      default:
        tradBillions = _convertLessThanOneThousand(billions) + ' $_billion ';
    }
    return tradBillions;
  }

  static String _getMillions(int millions) {
    String tradMillions;
    switch (millions) {
      case 0:
        tradMillions = '';
        break;
      case 1:
        tradMillions = _convertLessThanOneThousand(millions) + ' $_million ';
        break;
      default:
        tradMillions = _convertLessThanOneThousand(millions) + ' $_million ';
    }
    return tradMillions;
  }

  static String _getThousands(int hundredThousands) {
    String tradHundredThousands;
    switch (hundredThousands) {
      case 0:
        tradHundredThousands = '';
        break;
      case 1:
        tradHundredThousands =
            _convertLessThanOneThousand(hundredThousands) + ' $_thousand ';
        break;
      default:
        tradHundredThousands =
            _convertLessThanOneThousand(hundredThousands) + ' $_thousand ';
    }

    return tradHundredThousands;
  }
}
