
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterNumberToWordsEnglish {
  static const MethodChannel _channel = MethodChannel('flutter_number_to_words_english');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
