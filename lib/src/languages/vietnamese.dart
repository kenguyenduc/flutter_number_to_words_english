import '../language_base.dart';

/// Vietnamese language implementation for number to words conversion
class VietnameseNumberToWords extends NumberToWordsLanguage {
  @override
  String get languageCode => 'vi';

  @override
  String get languageName => 'Vietnamese';

  @override
  String get minusWord => 'âm';

  @override
  String get pointWord => 'phẩy';

  static const String _zero = 'không';
  static const String _hundred = 'trăm';
  static const String _thousand = 'nghìn';
  static const String _million = 'triệu';
  static const String _billion = 'tỷ';
  static const String _trillion = 'nghìn tỷ';

  static const List<String> _scaleNames = [
    '',
    _thousand,
    _million,
    _billion,
    _trillion,
  ];

  static const List<String> _numNames = [
    '',
    'một',
    'hai',
    'ba',
    'tư',
    'năm',
    'sáu',
    'bảy',
    'tám',
    'chín',
    'mười',
    'mười một',
    'mười hai',
    'mười ba',
    'mười tư',
    'mười năm',
    'mười sáu',
    'mười bảy',
    'mười tám',
    'mười chín'
  ];

  static const List<String> _tensNames = [
    '',
    'mười',
    'hai mười',
    'ba mười',
    'bốn mười',
    'năm mười',
    'sáu mười',
    'bảy mười',
    'tám mười',
    'chín mười'
  ];

  @override
  String convertLessThanOneThousand(int number) {
    if (number == 0) return '';

    String result = '';

    // Handle hundreds
    if (number >= 100) {
      int hundreds = number ~/ 100;
      result += '${_numNames[hundreds]} $_hundred';
      number %= 100;
      if (number > 0) result += ' ';
    }

    // Handle tens and ones
    if (number >= 20) {
      int tens = number ~/ 10;
      result += _tensNames[tens];
      number %= 10;
      if (number > 0) {
        result += ' ${_numNames[number]}';
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
          part += ' ${_scaleNames[scaleIndex]}';
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

  // Currency data for Vietnamese
  static const Map<String, Map<String, String>> _currencyData = {
    'USD': {'major': 'đô la Mỹ', 'majorPlural': 'đô la Mỹ', 'minor': 'xu', 'minorPlural': 'xu', 'decimals': '2'},
    'EUR': {'major': 'euro', 'majorPlural': 'euro', 'minor': 'xu', 'minorPlural': 'xu', 'decimals': '2'},
    'GBP': {'major': 'bảng Anh', 'majorPlural': 'bảng Anh', 'minor': 'xu', 'minorPlural': 'xu', 'decimals': '2'},
    'JPY': {'major': 'yên Nhật', 'majorPlural': 'yên Nhật', 'minor': '', 'minorPlural': '', 'decimals': '0'},
    'VND': {'major': 'đồng', 'majorPlural': 'đồng', 'minor': 'xu', 'minorPlural': 'xu', 'decimals': '2'},
    'CNY': {'major': 'nhân dân tệ', 'majorPlural': 'nhân dân tệ', 'minor': 'xu', 'minorPlural': 'xu', 'decimals': '2'},
    'KRW': {'major': 'won Hàn Quốc', 'majorPlural': 'won Hàn Quốc', 'minor': '', 'minorPlural': '', 'decimals': '0'},
    'THB': {'major': 'baht Thái', 'majorPlural': 'baht Thái', 'minor': 'xu', 'minorPlural': 'xu', 'decimals': '2'},
    'SGD': {'major': 'đô la Singapore', 'majorPlural': 'đô la Singapore', 'minor': 'xu', 'minorPlural': 'xu', 'decimals': '2'},
    'AUD': {'major': 'đô la Úc', 'majorPlural': 'đô la Úc', 'minor': 'xu', 'minorPlural': 'xu', 'decimals': '2'},
    'CAD': {'major': 'đô la Canada', 'majorPlural': 'đô la Canada', 'minor': 'xu', 'minorPlural': 'xu', 'decimals': '2'},
    'CHF': {'major': 'franc Thụy Sĩ', 'majorPlural': 'franc Thụy Sĩ', 'minor': 'xu', 'minorPlural': 'xu', 'decimals': '2'},
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
    String majorUnit = currency['major']!; // Vietnamese doesn't change for plural
    String result = '$majorWords $majorUnit';

    // Add minor amount if applicable
    if (decimals > 0 && minorAmount > 0) {
      String minorWords = convertIntegerPart(minorAmount);
      String minorUnit = currency['minor']!;
      result += ' $minorWords $minorUnit';
    }

    return result;
  }

  @override
  String convertOrdinal(int number) {
    if (number <= 0) {
      throw ArgumentError('Ordinal numbers must be positive integers');
    }

    // Special ordinal forms in Vietnamese
    switch (number) {
      case 1:
        return 'thứ nhất';
      case 2:
        return 'thứ hai';
      case 3:
        return 'thứ ba';
      case 4:
        return 'thứ tư';
      default:
        // For other numbers, use "thứ" + cardinal number
        return 'thứ ${convertIntegerPart(number)}';
    }
  }
}
