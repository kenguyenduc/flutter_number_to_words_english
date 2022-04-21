 ## flutter_number_to_words_english [![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/kenguyenduc/flutter_number_to_words_english/blob/master/LICENSE)
 A Flutter/Dart package that converts number to words (English language).

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
