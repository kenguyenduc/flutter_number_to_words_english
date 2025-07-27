# Number to Words English

[![pub package](https://img.shields.io/pub/v/number_to_words_english.svg)](https://pub.dev/packages/number_to_words_english)
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis

A Flutter/Dart package that converts numbers to their written English words representation.

## Features

✅ Convert integers to written English words  
✅ Supports numbers from 0 to trillion scale  
✅ Null safety support  
✅ Lightweight and fast  
✅ No external dependencies  
✅ Well tested and documented

## Getting started

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  number_to_words_english: ^2.1.0
```

Then run:

```bash
flutter pub get
```

## Usage

Import the package in your Dart file:

```dart
import 'package:number_to_words_english/number_to_words_english.dart';
```

### Basic usage

```dart
// Convert simple numbers
print(NumberToWordsEnglish.convert(55));
// Output: 'fifty-five'

print(NumberToWordsEnglish.convert(100));
// Output: 'one hundred'

print(NumberToWordsEnglish.convert(1000));
// Output: 'one thousand'
```

### Advanced examples

```dart
// Large numbers
print(NumberToWordsEnglish.convert(100000));
// Output: 'one hundred thousand'

print(NumberToWordsEnglish.convert(13578921));
// Output: 'thirteen million five hundred seventy-eight thousand nine hundred twenty-one'

print(NumberToWordsEnglish.convert(123456789));
// Output: 'one hundred twenty-three million four hundred fifty-six thousand seven hundred eighty-nine'

// Very large numbers (trillion scale)
print(NumberToWordsEnglish.convert(5553456987345));
// Output: 'five trillion five hundred fifty-three billion four hundred fifty-six million nine hundred eighty-seven thousand three hundred forty-five'
```

### Complete example

```dart
import 'package:flutter/material.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Number to Words')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Number: 12345',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                'Words: ${NumberToWordsEnglish.convert(12345)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## API reference

### NumberToWordsEnglish

#### Methods

##### `static String convert(int number)`

Converts an integer to its English word representation.

**Parameters:**

- `number` (int): The number to convert. Must be a valid integer.

**Returns:**

- `String`: The English word representation of the number.

**Example:**

```dart
String result = NumberToWordsEnglish.convert(123);
// Returns: "one hundred twenty-three"
```

## Supported range

This package supports converting integers in the following range:

- **Minimum:** 0 (zero)
- **Maximum:** 999,999,999,999,999 (nine hundred ninety-nine trillion nine hundred ninety-nine billion nine hundred ninety-nine million nine hundred ninety-nine thousand nine hundred ninety-nine)

## Additional information

### Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Issues and feedback

Please file issues, bugs, or feature requests in our [issue tracker](https://github.com/kenguyenduc/flutter_number_to_words_english/issues).

### Links

- [Package on pub.dev](https://pub.dev/packages/number_to_words_english)
- [Source code on GitHub](https://github.com/kenguyenduc/flutter_number_to_words_english)
- [Documentation](https://pub.dev/documentation/number_to_words_english/latest/)

## 💖 Support

If you find this package helpful, consider supporting the development:

[![Buy Me A Coffee](https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png)](https://coff.ee/kenguyen)

<details>
<summary>📱 QR Code</summary>

<img src="buymecoffee_qr.png" alt="Buy Me A Coffee QR Code" width="200">

Or visit: [coff.ee/kenguyen](https://coff.ee/kenguyen)

</details>

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
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
```
