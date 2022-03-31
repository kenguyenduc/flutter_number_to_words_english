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
  final int _value = 123456789;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              /// 'one hundred twenty-three million four hundred fifty-six thousand seven hundred eighty-nine'
              Text(
                'Result: 123456789 -> ${NumberToWordsEnglish.convert(_value)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),

              ///'fifty-five'
              Text(
                NumberToWordsEnglish.convert(55),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),

              ///'one hundred thousand'
              Text(
                NumberToWordsEnglish.convert(100000),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),

              /// 'thirteen million five hundred seventy-eight thousand nine hundred twenty-one'
              Text(
                NumberToWordsEnglish.convert(13578921),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
