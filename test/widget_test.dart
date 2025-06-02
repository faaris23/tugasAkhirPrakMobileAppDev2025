// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/home_screen.dart';
import 'package:pokemon/main.dart';
import 'package:pokemon/pokedex.dart';
import 'package:pokemon/loginPage.dart';

void main() {

runApp(LoginPage());
  testWidgets('HomeScreen has a header with Pokédex title', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(),
      ),
    );

    // Check for the header text
    expect(find.text('Pokédex'), findsOneWidget);
  });


  testWidgets('LoginPage has username and password fields and login button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(),
      ),
    );

    // Check for username TextField
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.widgetWithText(TextField, 'Username'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);

    // Check for login button
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });

  testWidgets('LoginPage shows error on empty login', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(),
      ),
    );

    // Tap the login button without entering credentials
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    // Check for error message (assuming a SnackBar or Text appears)
    expect(find.textContaining('error', findRichText: true), findsWidgets);
  });

  // Add more tests as needed for your LoginPage logic
}

