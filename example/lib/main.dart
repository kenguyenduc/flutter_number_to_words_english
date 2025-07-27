import 'package:flutter/material.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _number = 123;
  String _selectedLanguage = 'en';
  final TextEditingController _controller = TextEditingController(text: '123');

  final Map<String, String> _languages = {
    'en': 'English',
    'vi': 'Vietnamese (Tiếng Việt)',
    'es': 'Spanish (Español)',
  };

  String get _numberInWords {
    try {
      return NumberToWords.convert(_selectedLanguage, _number);
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number to Words - Multi Language',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Number to Words'),
          elevation: 2,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Language Selection
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Language:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      DropdownButton<String>(
                        value: _selectedLanguage,
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLanguage = newValue!;
                          });
                        },
                        items: _languages.entries
                            .map<DropdownMenuItem<String>>((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Text(entry.value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Number Input
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter Number:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter a number...',
                          prefixIcon: Icon(Icons.numbers),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _number = int.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Result Display
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Result in ${_languages[_selectedLanguage]}:',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        child: Text(
                          _numberInWords,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Example Numbers
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Try These Examples:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [1, 21, 100, 123, 1000, 1234, 1000000]
                            .map((value) => OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _number = value;
                                      _controller.text = value.toString();
                                    });
                                  },
                                  child: Text(value.toString()),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // API Information
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'API Usage Examples:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Extension Methods
                            Text(
                              '// ✨ Extension Methods (New!)',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                color: Colors.blue[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '$_number.toWords() // English',
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                            Text(
                              '$_number.toVietnamese() // Vietnamese',
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                            Text(
                              '$_number.toSpanish() // Spanish',
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                            const SizedBox(height: 12),

                            // Multi-Language API
                            Text(
                              '// 🌍 Multi-Language API',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'NumberToWords.convert(\'$_selectedLanguage\', $_number)',
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                            Text(
                              '// Returns: "$_numberInWords"',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Legacy API
                            Text(
                              '// 🔧 Legacy API (backward compatible)',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                color: Colors.orange[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'NumberToWordsEnglish.convert($_number)',
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                            Text(
                              '// Returns: "${NumberToWordsEnglish.convert(_number)}"',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Extension Methods Demo
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '✨ Extension Methods Demo:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      _buildExtensionDemo(),
                      const SizedBox(height: 16),
                      _buildOrdinalDemo(),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Supported Languages
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Supported Languages:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      ...NumberToWords.supportedLanguagesWithNames.entries.map(
                        (entry) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  entry.key.toUpperCase(),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(entry.value),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExtensionDemo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Try these extension methods with $_number:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildExtensionExample('$_number.toWords()', _number.toWords()),
          _buildExtensionExample(
              '$_number.toVietnamese()', _number.toVietnamese()),
          _buildExtensionExample('$_number.toSpanish()', _number.toSpanish()),
          if (_number == _number.toInt()) ...[
            const SizedBox(height: 8),
            Text(
              'Integer-specific extensions:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
            const SizedBox(height: 4),
            _buildExtensionExample(
                '$_number.toCardinal()', _number.toInt().toCardinal()),
            _buildExtensionExample('$_number.canConvertToWords()',
                '${_number.toInt().canConvertToWords()}'),
            _buildExtensionExample(
                '$_number.wordCount()', '${_number.toInt().wordCount()}'),
          ],
          const SizedBox(height: 8),
          Text(
            'String extension:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.purple[700],
            ),
          ),
          const SizedBox(height: 4),
          _buildExtensionExample(
              '"$_number".toWordsFromString()', "$_number".toWordsFromString()),
        ],
      ),
    );
  }

  Widget _buildOrdinalDemo() {
    // Only show ordinals for positive integers
    if (_number != _number.toInt() || _number <= 0) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.format_list_numbered,
                  color: Colors.green[700], size: 16),
              const SizedBox(width: 4),
              Text(
                'Ordinal Numbers (${_number.toInt()}):',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Basic ordinal methods
          _buildOrdinalExample(
              '${_number.toInt()}.toOrdinal()', _number.toInt().toOrdinal()),
          _buildOrdinalExample('${_number.toInt()}.toOrdinalWords()',
              _number.toInt().toOrdinalWords()),

          const SizedBox(height: 8),
          Text(
            'Multi-language ordinals:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.green[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),

          // Multi-language ordinals
          _buildOrdinalExample('${_number.toInt()}.toOrdinalEnglish()',
              _number.toInt().toOrdinalEnglish()),
          _buildOrdinalExample('${_number.toInt()}.toOrdinalVietnamese()',
              _number.toInt().toOrdinalVietnamese()),
          _buildOrdinalExample('${_number.toInt()}.toOrdinalFrench()',
              _number.toInt().toOrdinalFrench()),
          _buildOrdinalExample('${_number.toInt()}.toOrdinalGerman()',
              _number.toInt().toOrdinalGerman()),
          _buildOrdinalExample('${_number.toInt()}.toOrdinalChinese()',
              _number.toInt().toOrdinalChinese()),
          _buildOrdinalExample('${_number.toInt()}.toOrdinalJapanese()',
              _number.toInt().toOrdinalJapanese()),

          if (_number.toInt() <= 10) ...[
            const SizedBox(height: 8),
            Text(
              'Additional methods:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green[600],
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            _buildOrdinalExample('${_number.toInt()}.getOrdinalSuffix()',
                _number.toInt().getOrdinalSuffix()),
            _buildOrdinalExample('${_number.toInt()}.canConvertToOrdinal()',
                '${_number.toInt().canConvertToOrdinal()}'),
          ],
        ],
      ),
    );
  }

  Widget _buildOrdinalExample(String code, String result) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(' → ', style: TextStyle(color: Colors.grey, fontSize: 12)),
          Expanded(
            flex: 4,
            child: Text(
              result,
              style: const TextStyle(
                fontSize: 11,
                fontStyle: FontStyle.italic,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtensionExample(String code, String result) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(' → ', style: TextStyle(color: Colors.grey)),
          Expanded(
            flex: 3,
            child: Text(
              result,
              style: const TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
