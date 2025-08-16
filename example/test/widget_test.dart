// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:number_to_words_english_example/main.dart';

void main() {
  testWidgets('Number to Words App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NumberToWordsApp());

    // Verify that our app has the correct title
    expect(find.text('Number to Words'), findsOneWidget);

    // Verify that we have tabs
    expect(find.text('Numbers'), findsOneWidget);
    expect(find.text('Currency'), findsOneWidget);
    expect(find.text('Ordinals'), findsOneWidget);
    expect(find.text('API Demo'), findsOneWidget);

    // Verify default number conversion
    expect(find.text('one hundred twenty-three'), findsWidgets);
  });

  testWidgets('Language selector test', (WidgetTester tester) async {
    await tester.pumpWidget(const NumberToWordsApp());

    // Find and tap the language dropdown
    expect(find.text('Select Language'), findsOneWidget);
    
    // Should have English selected by default
    expect(find.text('EN - English'), findsOneWidget);
  });

  testWidgets('Number input test', (WidgetTester tester) async {
    await tester.pumpWidget(const NumberToWordsApp());

    // Find the number input field
    final numberField = find.byType(TextFormField).first;
    expect(numberField, findsOneWidget);

    // Enter a new number
    await tester.enterText(numberField, '456');
    await tester.pump();

    // Should display the converted number
    expect(find.text('four hundred fifty-six'), findsWidgets);
  });
}
