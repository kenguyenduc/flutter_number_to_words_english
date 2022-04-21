import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_to_words_english/flutter_number_to_words_english.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_number_to_words_english');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterNumberToWordsEnglish.platformVersion, '42');
  });
}
