import 'package:flutter/material.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextStyle _textStyle = const TextStyle(
    fontSize: 16,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 'one hundred twenty-three million four hundred fifty-six thousand seven hundred eighty-nine'
                Text(
                  '123456789 -> ${NumberToWordsEnglish.convert(123456789)} \n',
                  style: _textStyle,
                ),

                ///'fifty-five'
                Text(
                  '55 -> ${NumberToWordsEnglish.convert(55)} \n',
                  style: _textStyle,
                ),

                ///'one hundred thousand'
                Text(
                  '100000 -> ${NumberToWordsEnglish.convert(100000)} \n',
                  style: _textStyle,
                ),

                ///'one million'
                Text(
                  '1000000 -> ${NumberToWordsEnglish.convert(1000000)} \n',
                  style: _textStyle,
                ),

                /// 'thirteen million five hundred seventy-eight thousand nine hundred twenty-one'
                Text(
                  '13578921 -> ${NumberToWordsEnglish.convert(13578921)} \n',
                  style: _textStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
