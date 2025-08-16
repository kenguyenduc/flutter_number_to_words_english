import '../language_base.dart';

/// Arabic language implementation for number to words conversion
class ArabicNumberToWords extends NumberToWordsLanguage {
  @override
  String get languageCode => 'ar';

  @override
  String get languageName => 'Arabic';

  @override
  String get minusWord => 'ناقص';

  @override
  String get pointWord => 'فاصلة';

  static const String _zero = 'صفر';
  static const String _hundred = 'مائة';

  static const List<String> _scaleNames = [
    '',
    'ألف',
    'مليون',
    'مليار',
    'ترليون',
  ];

  static const List<String> _numNames = [
    '',
    'واحد',
    'اثنان',
    'ثلاثة',
    'أربعة',
    'خمسة',
    'ستة',
    'سبعة',
    'ثمانية',
    'تسعة',
    'عشرة',
    'أحد عشر',
    'اثنا عشر',
    'ثلاثة عشر',
    'أربعة عشر',
    'خمسة عشر',
    'ستة عشر',
    'سبعة عشر',
    'ثمانية عشر',
    'تسعة عشر'
  ];

  static const List<String> _tensNames = [
    '',
    'عشرة',
    'عشرون',
    'ثلاثون',
    'أربعون',
    'خمسون',
    'ستون',
    'سبعون',
    'ثمانون',
    'تسعون'
  ];

  @override
  String convertLessThanOneThousand(int number) {
    if (number == 0) return '';

    String result = '';

    // Handle hundreds
    if (number >= 100) {
      int hundreds = number ~/ 100;
      if (hundreds == 1) {
        result = _hundred;
      } else if (hundreds == 2) {
        result = 'مائتان';
      } else {
        result = '${_numNames[hundreds]} $_hundred';
      }
      number %= 100;
      if (number > 0) result += ' و';
    }

    // Handle tens and ones
    if (number >= 20) {
      int tens = number ~/ 10;
      int ones = number % 10;
      if (ones > 0) {
        // In Arabic, ones come before tens: "واحد وعشرون" (one and twenty)
        result += '${_numNames[ones]} و${_tensNames[tens]}';
      } else {
        result += _tensNames[tens];
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
        String part;
        if (scaleIndex > 0) {
          // Handle pluralization for thousands, millions, etc.
          String scaleName;
          if (remainder == 1) {
            scaleName = _scaleNames[scaleIndex];
            part = scaleName; // e.g., "ألف", "مليون"
          } else if (remainder == 2) {
            scaleName = _scaleNames[scaleIndex];
            part = '${scaleName}ان'; // e.g., "ألفان"
          } else if (remainder >= 3 && remainder <= 10) {
            scaleName = _scaleNames[scaleIndex];
            part =
                '${convertLessThanOneThousand(remainder)} ${scaleName}'; // e.g., "ثلاثة آلاف"
          } else {
            scaleName = _scaleNames[scaleIndex];
            part = '${convertLessThanOneThousand(remainder)} ${scaleName}';
          }
        } else {
          part = convertLessThanOneThousand(remainder);
        }
        parts.insert(0, part);
      }
      number ~/= 1000;
      scaleIndex++;
    }

    return parts.join(' و');
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

  // Currency data for Arabic
  static const Map<String, Map<String, String>> _currencyData = {
    'USD': {
      'major': 'دولار',
      'majorPlural': 'دولار',
      'minor': 'سنت',
      'minorPlural': 'سنت',
      'decimals': '2'
    },
    'EUR': {
      'major': 'يورو',
      'majorPlural': 'يورو',
      'minor': 'سنت',
      'minorPlural': 'سنت',
      'decimals': '2'
    },
    'GBP': {
      'major': 'جنيه',
      'majorPlural': 'جنيه',
      'minor': 'بنس',
      'minorPlural': 'بنس',
      'decimals': '2'
    },
    'JPY': {
      'major': 'ين',
      'majorPlural': 'ين',
      'minor': '',
      'minorPlural': '',
      'decimals': '0'
    },
    'VND': {
      'major': 'دونغ',
      'majorPlural': 'دونغ',
      'minor': 'شو',
      'minorPlural': 'شو',
      'decimals': '2'
    },
    'CNY': {
      'major': 'يوان',
      'majorPlural': 'يوان',
      'minor': 'جياو',
      'minorPlural': 'جياو',
      'decimals': '2'
    },
    'KRW': {
      'major': 'وون',
      'majorPlural': 'وون',
      'minor': '',
      'minorPlural': '',
      'decimals': '0'
    },
    'THB': {
      'major': 'بات',
      'majorPlural': 'بات',
      'minor': 'ساتانغ',
      'minorPlural': 'ساتانغ',
      'decimals': '2'
    },
    'SGD': {
      'major': 'دولار سنغافوري',
      'majorPlural': 'دولار سنغافوري',
      'minor': 'سنت',
      'minorPlural': 'سنت',
      'decimals': '2'
    },
    'AUD': {
      'major': 'دولار أسترالي',
      'majorPlural': 'دولار أسترالي',
      'minor': 'سنت',
      'minorPlural': 'سنت',
      'decimals': '2'
    },
    'CAD': {
      'major': 'دولار كندي',
      'majorPlural': 'دولار كندي',
      'minor': 'سنت',
      'minorPlural': 'سنت',
      'decimals': '2'
    },
    'CHF': {
      'major': 'فرنك سويسري',
      'majorPlural': 'فرنك سويسري',
      'minor': 'سنتيم',
      'minorPlural': 'سنتيم',
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
    String majorUnit = currency['major']!; // Arabic doesn't change for plural
    String result = '$majorWords $majorUnit';

    // Add minor amount if applicable
    if (decimals > 0 && minorAmount > 0) {
      String minorWords = convertIntegerPart(minorAmount);
      String minorUnit = currency['minor']!;
      result += ' و $minorWords $minorUnit'; // "و" = "and" in Arabic
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
        return 'الأول';
      case 2:
        return 'الثاني';
      case 3:
        return 'الثالث';
      case 4:
        return 'الرابع';
      case 5:
        return 'الخامس';
      case 6:
        return 'السادس';
      case 7:
        return 'السابع';
      case 8:
        return 'الثامن';
      case 9:
        return 'التاسع';
      case 10:
        return 'العاشر';
      default:
        // For larger numbers, use simplified approach
        String baseWords = convertIntegerPart(number);
        return 'ال$baseWords'; // Adding definite article "al"
    }
  }
}
