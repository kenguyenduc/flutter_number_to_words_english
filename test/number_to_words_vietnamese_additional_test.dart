import 'package:flutter_test/flutter_test.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

void main() {
  group('Vietnamese Specific Rules', () {
    test('Tens and special ones', () {
      expect(NumberToWords.convert('vi', 10), 'Mười');
      expect(NumberToWords.convert('vi', 11), 'mười một');
      expect(NumberToWords.convert('vi', 14), 'mười bốn');
      expect(NumberToWords.convert('vi', 15), 'mười lăm');
      expect(NumberToWords.convert('vi', 20), 'hai mươi');
      expect(NumberToWords.convert('vi', 21), 'hai mươi mốt');
      expect(NumberToWords.convert('vi', 24), 'hai mươi tư');
      expect(NumberToWords.convert('vi', 25), 'hai mươi lăm');
      expect(NumberToWords.convert('vi', 30), 'ba mươi');
    });

    test('Hundreds with zero tens uses "lẻ"', () {
      expect(NumberToWords.convert('vi', 101), 'một trăm lẻ một');
      expect(NumberToWords.convert('vi', 105), 'một trăm lẻ năm');
      expect(NumberToWords.convert('vi', 109), 'một trăm lẻ chín');
    });
  });
}
