import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:anime_pin_code_field/anime_pin_code_field.dart';

void main() {
  testWidgets('AnimePinCodeField widget test', (WidgetTester tester) async {
    String? submittedPin;
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimePinCodeField(
            onSubmitClick: (pinCode) {
              submittedPin = pinCode;
            },
          ),
        ),
      ),
    );

    expect(find.byType(AnimePinCodeField), findsOneWidget);
  });
}
