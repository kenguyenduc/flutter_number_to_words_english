import 'package:flutter_test/flutter_test.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

void main() {
  group('NumberToWordsEnglish', () {
    final List<MapEntry<num, String>> testNumbers = <MapEntry<num, String>>[
      const MapEntry(1, 'one'),
      const MapEntry(2, 'two'),
      const MapEntry(3, 'three'),
      const MapEntry(4, 'four'),
      const MapEntry(5, 'five'),
      const MapEntry(6, 'six'),
      const MapEntry(7, 'seven'),
      const MapEntry(8, 'eight'),
      const MapEntry(9, 'nine'),
      const MapEntry(10, 'ten'),
      const MapEntry(11, 'eleven'),
      const MapEntry(12, 'twelve'),
      const MapEntry(13, 'thirteen'),
      const MapEntry(14, 'fourteen'),
      const MapEntry(15, 'fifteen'),
      const MapEntry(16, 'sixteen'),
      const MapEntry(17, 'seventeen'),
      const MapEntry(18, 'eighteen'),
      const MapEntry(19, 'nineteen'),
      const MapEntry(20, 'twenty'),
      const MapEntry(25, 'twenty-five'),
      const MapEntry(45, 'forty-five'),
      const MapEntry(55, 'fifty-five'),
      const MapEntry(100, 'one hundred'),
      const MapEntry(1000, 'one thousand'),
      const MapEntry(10000, 'ten thousand'),
      const MapEntry(100000, 'one hundred thousand'),
      const MapEntry(1000000, 'one million'),
      const MapEntry(1500000, 'one million five hundred thousand'),
      const MapEntry(100000000, 'one hundred million'),
      const MapEntry(1000000000, 'one billion'),
      const MapEntry(13578921,
          'thirteen million five hundred seventy-eight thousand nine hundred twenty-one'),
      const MapEntry(-13578921,
          'minus thirteen million five hundred seventy-eight thousand nine hundred twenty-one'),
      const MapEntry(123, 'one hundred twenty-three'),
      const MapEntry(-123.45, 'minus one hundred twenty-three point four five'),
      const MapEntry(123.45, 'one hundred twenty-three point four five'),
      const MapEntry(5553456987345,
          'five trillion five hundred fifty-three billion four hundred fifty-six million nine hundred eighty-seven thousand three hundred forty-five'),
      const MapEntry(5553456987345.123,
          'five trillion five hundred fifty-three billion four hundred fifty-six million nine hundred eighty-seven thousand three hundred forty-five point one two three'),
      const MapEntry(123456789,
          'one hundred twenty-three million four hundred fifty-six thousand seven hundred eighty-nine'),
      const MapEntry(9223372036854775807,
          'nine quintillion two hundred twenty-three quadrillion three hundred seventy-two trillion thirty-six billion eight hundred fifty-four million seven hundred seventy-five thousand eight hundred seven'),
    ];

    for (int i = 0; i < testNumbers.length; i++) {
      test('TestCase ${i + 1}', () {
        String words = NumberToWordsEnglish.convert(testNumbers[i].key);
        expect(words, testNumbers[i].value);
      });
    }
  });
}
