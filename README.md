 ## flutter_number_to_words_english

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link] [![effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://dart.dev/guides/language/effective-dart) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/kenguyenduc/flutter_number_to_words_english/blob/master/LICENSE)

[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis

A Flutter/Dart package that converts number to words (English language).

https://flutterawesome.com/a-flutter-dart-package-that-converts-number-to-words-english-language/

 For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

#### :small_orange_diamond: Usage
```sh
import 'package:number_to_words_english/number_to_words_english.dart';

NumberToWordsEnglish.convert(55);
//'fifty-five'

NumberToWordsEnglish.convert(100000);
//'one hundred thousand'

NumberToWordsEnglish.convert(13578921);
// 'thirteen million five hundred seventy-eight thousand nine hundred twenty-one'

NumberToWordsEnglish.convert(123456789);
// 'one hundred twenty-three million four hundred fifty-six thousand seven hundred eighty-nine'

NumberToWordsEnglish.convert(5553456987345);
// 'five trillion five hundred fifty-three billion four hundred fifty-six million nine hundred eighty-seven thousand three hundred forty-five'

```

License
----------
MIT License

Copyright (c) 2022 Ke Nguyen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
