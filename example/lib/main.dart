import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

void main() {
  runApp(const NumberToWordsApp());
}

class NumberToWordsApp extends StatelessWidget {
  const NumberToWordsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number to Words Multi-Language Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const NumberConverterHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NumberConverterHome extends StatefulWidget {
  const NumberConverterHome({super.key});

  @override
  State<NumberConverterHome> createState() => _NumberConverterHomeState();
}

class _NumberConverterHomeState extends State<NumberConverterHome>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _numberController = 
      TextEditingController(text: '123');
  final TextEditingController _currencyController = 
      TextEditingController(text: '123.45');
  final TextEditingController _ordinalController = 
      TextEditingController(text: '21');

  String _selectedLanguage = 'en';
  String _selectedCurrency = 'USD';
  num _currentNumber = 123;
  double _currentCurrencyAmount = 123.45;
  int _currentOrdinalNumber = 21;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _numberController.dispose();
    _currencyController.dispose();
    _ordinalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              'Number to Words',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '12 Languages • 12 Currencies • Ordinals',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
          unselectedLabelColor: Theme.of(context)
              .colorScheme
              .onPrimaryContainer
              .withValues(alpha: 0.7),
          indicatorColor: Theme.of(context).colorScheme.primary,
          tabs: const [
            Tab(icon: Icon(Icons.translate), text: 'Numbers'),
            Tab(icon: Icon(Icons.attach_money), text: 'Currency'),
            Tab(icon: Icon(Icons.format_list_numbered), text: 'Ordinals'),
            Tab(icon: Icon(Icons.code), text: 'API Demo'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNumberTab(),
          _buildCurrencyTab(),
          _buildOrdinalTab(),
          _buildApiDemoTab(),
        ],
      ),
    );
  }

  Widget _buildNumberTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildLanguageSelector(),
          const SizedBox(height: 16),
          _buildNumberInput(),
          const SizedBox(height: 16),
          _buildNumberResult(),
          const SizedBox(height: 24),
          _buildQuickNumberButtons(),
          const SizedBox(height: 24),
          _buildExtensionMethodsDemo(),
        ],
      ),
    );
  }

  Widget _buildCurrencyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCurrencySelector(),
          const SizedBox(height: 16),
          _buildCurrencyInput(),
          const SizedBox(height: 16),
          _buildCurrencyResult(),
          const SizedBox(height: 24),
          _buildCurrencyExamples(),
          const SizedBox(height: 24),
          _buildMultiLanguageCurrency(),
        ],
      ),
    );
  }

  Widget _buildOrdinalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildOrdinalInput(),
          const SizedBox(height: 16),
          _buildOrdinalResult(),
          const SizedBox(height: 24),
          _buildOrdinalExamples(),
          const SizedBox(height: 24),
          _buildMultiLanguageOrdinals(),
        ],
      ),
    );
  }

  Widget _buildApiDemoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSupportedLanguages(),
          const SizedBox(height: 24),
          _buildApiExamples(),
          const SizedBox(height: 24),
          _buildExtensionMethodsReference(),
          const SizedBox(height: 24),
          _buildLibraryInfo(),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.language, 
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Select Language',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedLanguage,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.translate),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: NumberToWords.supportedLanguagesWithNames.entries
                  .map<DropdownMenuItem<String>>((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text('${entry.key.toUpperCase()} - ${entry.value}'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberInput() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.numbers, 
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Enter Number',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _numberController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a number (e.g., 123, -456, 78.9)',
                prefixIcon: Icon(Icons.calculate),
                suffixIcon: Icon(Icons.clear),
              ),
              onChanged: (value) {
                setState(() {
                  _currentNumber = num.tryParse(value) ?? 0;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberResult() {
    String result;
    try {
      result = NumberToWords.convert(_selectedLanguage, _currentNumber);
    } catch (e) {
      result = 'Error: ${e.toString()}';
    }

    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.record_voice_over,
                     color: Theme.of(context).colorScheme.onSecondaryContainer),
                const SizedBox(width: 8),
                Text(
                  'Result in ${NumberToWords.supportedLanguagesWithNames[_selectedLanguage]}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
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
              child: SelectableText(
                result,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: result));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to clipboard!')),
                    );
                  },
                  tooltip: 'Copy to clipboard',
                ),
                const Spacer(),
                Text(
                  'Number: $_currentNumber',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickNumberButtons() {
    final examples = [0, 1, 7, 21, 100, 123, 1000, 1234, 10000, 100000, 1000000];
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.touch_app,
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Quick Examples',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: examples.map((value) => FilledButton.tonal(
                    onPressed: () {
                      setState(() {
                        _currentNumber = value;
                        _numberController.text = value.toString();
                      });
                    },
                    child: Text(value.toString()),
                  )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExtensionMethodsDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.extension,
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Extension Methods Demo',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExtensionExample(
                      '$_currentNumber.toWords()', 
                      _currentNumber.toWords()),
                  _buildExtensionExample(
                      '$_currentNumber.toVietnamese()', 
                      _currentNumber.toVietnamese()),
                  _buildExtensionExample(
                      '$_currentNumber.toSpanish()', 
                      _currentNumber.toSpanish()),
                  _buildExtensionExample(
                      '$_currentNumber.toFrench()', 
                      _currentNumber.toFrench()),
                  _buildExtensionExample(
                      '$_currentNumber.toChinese()', 
                      _currentNumber.toChinese()),
                  if (_currentNumber is int && _currentNumber > 0) ...[
                    const Divider(),
                    Text(
                      'Integer-specific methods:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildExtensionExample(
                        '${_currentNumber.toInt()}.toCardinal()', 
                        _currentNumber.toInt().toCardinal()),
                    _buildExtensionExample(
                        '${_currentNumber.toInt()}.canConvertToWords()', 
                        '${_currentNumber.toInt().canConvertToWords()}'),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencySelector() {
    final currencies = {
      'USD': 'US Dollar (\$)',
      'EUR': 'Euro (€)',
      'GBP': 'British Pound (£)',
      'JPY': 'Japanese Yen (¥)',
      'VND': 'Vietnamese Dong (₫)',
      'CNY': 'Chinese Yuan (¥)',
      'KRW': 'Korean Won (₩)',
      'THB': 'Thai Baht (฿)',
      'SGD': 'Singapore Dollar (S\$)',
      'AUD': 'Australian Dollar (A\$)',
      'CAD': 'Canadian Dollar (C\$)',
      'CHF': 'Swiss Franc (CHF)',
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.monetization_on,
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Select Currency',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedCurrency,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_exchange),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCurrency = newValue!;
                });
              },
              items: currencies.entries
                  .map<DropdownMenuItem<String>>((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text('${entry.key} - ${entry.value}'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyInput() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.attach_money,
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Enter Amount',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _currencyController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter amount (e.g., 123.45)',
                prefixIcon: Icon(Icons.account_balance_wallet),
              ),
              onChanged: (value) {
                setState(() {
                  _currentCurrencyAmount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyResult() {
    String result;
    try {
      result = NumberToWords.convertCurrency(
          _selectedLanguage, _currentCurrencyAmount, _selectedCurrency);
    } catch (e) {
      result = 'Error: ${e.toString()}';
    }

    return Card(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.paid,
                     color: Theme.of(context).colorScheme.onTertiaryContainer),
                const SizedBox(width: 8),
                Text(
                  'Currency Result',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onTertiaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
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
              child: SelectableText(
                result,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyExamples() {
    final examples = [1.0, 12.34, 100.0, 1000.50, 1234.56];
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.quiz,
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Currency Examples',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: examples.map((value) => FilledButton.tonal(
                    onPressed: () {
                      setState(() {
                        _currentCurrencyAmount = value;
                        _currencyController.text = value.toString();
                      });
                    },
                    child: Text(value.toString()),
                  )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultiLanguageCurrency() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.language,
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Multi-Language Currency Demo',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExtensionExample(
                      '${_currentCurrencyAmount.toStringAsFixed(2)}.toUSD()', 
                      _currentCurrencyAmount.toUSD()),
                  _buildExtensionExample(
                      '${_currentCurrencyAmount.toStringAsFixed(2)}.toEUR()', 
                      _currentCurrencyAmount.toEUR()),
                  _buildExtensionExample(
                      '${_currentCurrencyAmount.toStringAsFixed(2)}.toVND()', 
                      _currentCurrencyAmount.toVND()),
                  _buildExtensionExample(
                      '${_currentCurrencyAmount.toStringAsFixed(2)}.toCNY()', 
                      _currentCurrencyAmount.toCNY()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdinalInput() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.format_list_numbered,
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Enter Number for Ordinal',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _ordinalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter positive integer (e.g., 21)',
                prefixIcon: Icon(Icons.looks_one),
              ),
              onChanged: (value) {
                setState(() {
                  _currentOrdinalNumber = int.tryParse(value) ?? 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdinalResult() {
    String result;
    try {
      if (_currentOrdinalNumber <= 0) {
        result = 'Please enter a positive integer';
      } else {
        result = NumberToWords.convertOrdinal(_selectedLanguage, _currentOrdinalNumber);
      }
    } catch (e) {
      result = 'Error: ${e.toString()}';
    }

    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.emoji_events,
                     color: Theme.of(context).colorScheme.onPrimaryContainer),
                const SizedBox(width: 8),
                Text(
                  'Ordinal Result',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
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
              child: SelectableText(
                result,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdinalExamples() {
    final examples = [1, 2, 3, 11, 21, 22, 101, 1001];
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.list,
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Ordinal Examples',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: examples.map((value) => FilledButton.tonal(
                    onPressed: () {
                      setState(() {
                        _currentOrdinalNumber = value;
                        _ordinalController.text = value.toString();
                      });
                    },
                    child: Text(value.toString()),
                  )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultiLanguageOrdinals() {
    if (_currentOrdinalNumber <= 0) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.language,
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Multi-Language Ordinals',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExtensionExample(
                      '$_currentOrdinalNumber.toOrdinal()', 
                      _currentOrdinalNumber.toOrdinal()),
                  _buildExtensionExample(
                      '$_currentOrdinalNumber.toOrdinalVietnamese()', 
                      _currentOrdinalNumber.toOrdinalVietnamese()),
                  _buildExtensionExample(
                      '$_currentOrdinalNumber.toOrdinalFrench()', 
                      _currentOrdinalNumber.toOrdinalFrench()),
                  _buildExtensionExample(
                      '$_currentOrdinalNumber.toOrdinalGerman()', 
                      _currentOrdinalNumber.toOrdinalGerman()),
                  _buildExtensionExample(
                      '$_currentOrdinalNumber.toOrdinalChinese()', 
                      _currentOrdinalNumber.toOrdinalChinese()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportedLanguages() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.public,
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Supported Languages (${NumberToWords.supportedLanguages.length})',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: NumberToWords.supportedLanguagesWithNames.entries.map(
                (entry) => Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      entry.key.toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  label: Text(entry.value),
                  onDeleted: () {
                    setState(() {
                      _selectedLanguage = entry.key;
                    });
                  },
                  deleteIcon: const Icon(Icons.arrow_forward),
                ),
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApiExamples() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.code,
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'API Usage Examples',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '// Multi-Language API',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "NumberToWords.convert('$_selectedLanguage', $_currentNumber);",
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                  Text(
                    '// Returns: "${NumberToWords.convert(_selectedLanguage, _currentNumber)}"',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: Theme.of(context).colorScheme.outline,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '// Extension Methods',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$_currentNumber.toWords(); // English',
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                  Text(
                    '$_currentNumber.toVietnamese(); // Vietnamese',
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '// Legacy API (backward compatible)',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'NumberToWordsEnglish.convert($_currentNumber);',
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExtensionMethodsReference() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.extension,
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Extension Methods Reference',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('• .toWords() - Convert to English words'),
            const Text('• .toVietnamese() - Convert to Vietnamese'),
            const Text('• .toSpanish() - Convert to Spanish'),
            const Text('• .toFrench() - Convert to French'),
            const Text('• .toGerman() - Convert to German'),
            const Text('• .toChinese() - Convert to Chinese'),
            const Text('• .toJapanese() - Convert to Japanese'),
            const Text('• .toArabic() - Convert to Arabic'),
            const SizedBox(height: 8),
            const Text('Currency extensions:'),
            const Text('• .toUSD(), .toEUR(), .toGBP(), .toJPY()'),
            const Text('• .toVND(), .toCNY(), .toKRW(), .toTHB()'),
            const SizedBox(height: 8),
            const Text('Ordinal extensions:'),
            const Text('• .toOrdinal() - English ordinals'),
            const Text('• .toOrdinalVietnamese(), .toOrdinalFrench()'),
            const Text('• .getOrdinalSuffix() - Get suffix (st, nd, rd, th)'),
          ],
        ),
      ),
    );
  }

  Widget _buildLibraryInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info,
                     color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Library Information',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Languages Supported'),
              subtitle: Text('${NumberToWords.supportedLanguages.length} languages'),
              dense: true,
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on),
              title: const Text('Currency Support'),
              subtitle: const Text('12 major currencies'),
              dense: true,
            ),
            ListTile(
              leading: const Icon(Icons.format_list_numbered),
              title: const Text('Ordinal Numbers'),
              subtitle: const Text('1st, 2nd, 3rd format support'),
              dense: true,
            ),
            ListTile(
              leading: const Icon(Icons.extension),
              title: const Text('Extension Methods'),
              subtitle: const Text('Convenient .toWords() syntax'),
              dense: true,
            ),
            ListTile(
              leading: const Icon(Icons.backup),
              title: const Text('Backward Compatible'),
              subtitle: const Text('Legacy NumberToWordsEnglish API'),
              dense: true,
            ),
          ],
        ),
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
}