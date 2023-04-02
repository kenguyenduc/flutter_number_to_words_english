import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final TextEditingController _inputNumberController = TextEditingController();
  String _result = '';
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _inputNumberController.selection = TextSelection(
            baseOffset: 0, extentOffset: _inputNumberController.text.length);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _inputNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Number to words english'),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              /// 'one hundred twenty-three million four hundred fifty-six thousand seven hundred eighty-nine'
              '123456789 -> ${NumberToWordsEnglish.convert(123456789)} \n',
              style: _textStyle,
            ),
            Text(
              ///'fifty-five'
              '55 -> ${NumberToWordsEnglish.convert(55)} \n',
              style: _textStyle,
            ),
            Text(
              ///'one hundred thousand'
              '100000 -> ${NumberToWordsEnglish.convert(100000)} \n',
              style: _textStyle,
            ),
            Text(
              ///'one million'
              '1000000 -> ${NumberToWordsEnglish.convert(1000000)} \n',
              style: _textStyle,
            ),
            Text(
              /// 'thirteen million five hundred seventy-eight thousand nine hundred twenty-one'
              '13578921 -> ${NumberToWordsEnglish.convert(13578921)} \n',
              style: _textStyle,
            ),
            const SizedBox(height: 32),
            _buildInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildInput() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _inputNumberController,
          focusNode: _focusNode,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.number,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            hintText: 'Enter Number...',
            counterText: '',
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                int? value = int.tryParse(_inputNumberController.text);
                _result =
                    value == null ? '' : NumberToWordsEnglish.convert(value);
                setState(() {});
              },
              icon: const Icon(Icons.arrow_forward),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          _result,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: _result));
          },
          child: const Text('Copy Text'),
        ),
      ],
    );
  }
}
